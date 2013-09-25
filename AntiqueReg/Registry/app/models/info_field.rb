class InfoField
  include Mongoid::Document
  field :name
  field :value
  field :universal, type: Boolean

  embedded_in :owner, class_name: "Artifact", inverse_of: :info_fields
  has_and_belongs_to_many :permission_groups, inverse_of: nil

  def to_s
    return value
  end

  def empty?
    return value.empty?
  end

  def strftime(s)
    return value.strftime(s)
  end
end
