require 'lingua/stemmer'
class Artifact
  include Mongoid::Document

  field :universal, type: Boolean, default: true
  field :name, type: String

  field :enabled, type: Boolean, default: true

  field :keywords, type: Array, default: []
  field :description, type: String
  field :length
  field :width
  field :quality

  field :discoverer, type String
  field :discoveryLocation, type String
  field :discoveryDate, type String
  field :creator, type String
  field :creationLocation, type String
  field :creationDate, type String
  field :fieldGPS, type String

  field :previousOwners, type Array, default: []

  field :typology, type String
  field :material, type String
  field :culturalAffiliation, type String
  field :restorations, type String
  field :damagedAreas, type String
  field :authenticationInformation, type String
  field :preservationProtocol, type String

  field :publicationReferences, type String
  field :technicalReportsSources, type String
  field :linksToOtherRegistries, type String
  field :miscInfo, type String

  embeds_many :info_fields

  embeds_one :main_picture, :class_name => "Picture"

  embeds_many :pictures, :cascade_callbacks => true
  embeds_many :info_fields
  accepts_nested_attributes_for :pictures
  attr_accessible :pictures, :info_fields, :name, :keywords



  attr_accessible :pictures, :info_fields
  belongs_to :artifact_collection, :class_name => "ArtifactCollection", :inverse_of=> :artifacts
  has_and_belongs_to_many :permission_groups, :inverse_of => nil
  belongs_to :owner, :class_name => 'User'

  before_save :assert_universality, :update_search_index

  #get and set non-standard fields ONLY through these methods
  def method_missing(method, *args)
    method_name = method.to_s
    if not args.empty?
      if method_name.include?("=")
        set_field(method_name[0..-2],args[0])
      else
        set_field(method_name,args[0])
      end
    elsif info_fields.map(&:name).include?(method_name)
      return info_fields.find_by(name: method_name)
    else
      ""
    end
  end

  def set_field(field_name, field_value)
    if info_fields.where(name: field_name).exists?
      info_fields.find(name: field_name).value = field_value
    else
      field = InfoField.new(name: field_name, value: field_value)
      field.owner= self
    end
  end

  def provenance
    field = info_fields.find_or_create_by(name: 'provenance')
    field.value || field.value = []
  end

  #If universal is set to true, add a universal permission group by default
  def set_defaults_to_universal
    universal_array = PermissionGroup.where(owner: self.owner).where(universal: true).to_a
    universal_array = [PermissionGroup.new(name: "universal", universal:true, owner: self.owner)] if universal_array.empty?
    self.permission_groups = universal_array
  end

  def remove_universal
    self.permission_groups.where(universal: true).delete
  end

  def sanitize_dynamic_fields
    universal_array = self.permission_groups.select(&:universal)
    info_fields.each do |info_field|
      if info_field.permission_groups.empty?
        info_field.permission_groups = universal_array
      else
        info_field.permission_groups=info_field.permission_groups.reject(&:universal)
      end
    end
  end

  def assert_universality
    if self.universal and not self.permission_groups.any?(&:universal)
      set_defaults_to_universal
    elsif not self.universal
      remove_universal
    end
    sanitize_dynamic_fields
  end

  #Methods involved with updating the artifacts search index
  def update_search_index
    permission_hash = self.to_permission_hash
    if permission_hash
      permission_hash.each{|key, value| permission_hash[key] = Artifact.stem(value)}
      update_index(permission_hash) unless permission_hash.empty?
    end
  end

  def create_search_terms(group_word_tuple)
    permission_group, word_hash = group_word_tuple[0], group_word_tuple[1]
    word_hash.map{|word, frequency| SearchTerm.new(permission_group: permission_group, term: word, weight: frequency)}
  end

  def word_count_hash(words)
    grouped_words = words.group_by(&:to_s)
    grouped_words.each_with_object({}){|(key,value),results| results[key] = value.size}
  end

  def update_index(hash)
    hash = hash.each_with_object({}){|(key,value),results| results[key] = word_count_hash(value)}
    hash = hash.reject{|key,words| words.empty?}
    search_terms = hash.map(&method(:create_search_terms)).reduce(&:concat)
    ArtifactSearchIndex.new(artifact_id: self.id, search_terms: search_terms).save unless search_terms.nil?
  end

  def field_selector(key, value)
    value.kind_of? String or (value.kind_of? Array and key!='permission_group_ids')
  end

  def to_permission_hash
    default_attribute_values = self.attributes.select(&method(:field_selector)).values
    permission_hash = default_attribute_values.reduce({}) do |results, value|
      value = value.join(' ') if value.kind_of? Array
      if value!=""
        value_hash = Hash[permission_groups.map(&:id).zip(Array.new(permission_groups.size,value))]
        results.merge(value_hash){|key,oldval,newval| "#{oldval} #{newval}"}
      else
        results
      end

    end
    permission_hash = info_fields.reduce(permission_hash) do |results, info_field|
      field_value = info_field.value
      field_value = field_value.join(' ') if field_value.kind_of? Array
      value_hash = Hash[info_field.permission_groups.map(&:id).zip(Array.new(info_field.permission_groups.size, field_value))]
      results.merge(value_hash){|key,oldval,newval| "#{oldval} #{newval}"}
    end
  end

  def self.stem(unstemmed)
    stop_words = %w(
    a able about across after all almost also am among an and any are as at
    be because been but by can cannot could dear did do does either else
    ever every for from get got had has have he her hers him his how however
    i if in into is it its just least let like likely may me might most must
    my neither no none nor not of off often on only or other our own rather said
    say says she should since so some than that the their them then there
    these they this tis to too twas us wants was we were what when where
    which while who whom why will with would yet you your
    )

    text_array = (unstemmed.kind_of? String) ? unstemmed.split() : unstemmed
    unstemmed_words = text_array.map(&:downcase).select{|word| not stop_words.include? word}
    Lingua.stemmer(unstemmed_words).to_a
  end

  #Picture Related
  def add_picture(picture, is_cover, file_suffix)
    file_prefix = self.name.gsub( /[^a-zA-Z0-9_\.]/, '_') + '_'
    extension = File.extname(picture.original_filename)
    Picture.create(:image => picture.tempfile, :name => file_prefix+file_suffix , :order_number => file_suffix, :extension => extension, :is_cover => is_cover, :artifact => self)
  end

  def get_cover
    self.pictures.each do |p|
      if p.is_cover
        return p
      end
    end
    return nil
  end

  def get_pictures
    pictures = Array.new
    self.pictures.each do |p|
      if !p.is_cover
        pictures.push(p)
      end
    end
    return pictures
  end

  def delete_picture(picture)
    if !picture.nil?
      picture.image.clear
      self.pictures.delete(picture)
      self.save
    end
  end
end

