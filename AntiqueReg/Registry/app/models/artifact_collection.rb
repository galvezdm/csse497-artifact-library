class ArtifactCollection
  include Mongoid::Document
  field :name, type: String
  field :universal, type: Boolean
  field :keywords, type: Array, default: []
  has_and_belongs_to_many :artifacts, :inverse_of => nil
  belongs_to :owner, :class_name => "User", :inverse_of => :artifact_collections
  field :enabled, type: Boolean, default: true
  has_and_belongs_to_many :permission_groups, :inverse_of => nil

  def is_visible(user)
    if(self.owner == user)
      return true
    end

    if(self.universal)
      return true
    end
    permission_groups.each do |group|
      if (group.include?(user))
        return true
      end
    end
    return false
  end

  def get_visible_artifacts(searcher_id)
    searcher = User.find(searcher_id)

    if(searcher_id == self.owner.id)
      return self.artifacts
    end

    permissions_group = searcher.get_permissions_group(self.owner.id)
    visible = []
    if(permissions_group == nil)
      self.artifacts.each do |artifact|
        if(artifact.universal)
          visible << artifact
        end
      end
    else
      self.artifacts.each do |artifact|
        if(artifact.permission_groups.include?(permissions_group) || artifact.universal)
          visible << artifact
        end
      end
    end
    return visible
  end

  def add_keyword(keyword)
    if(self.keywords.nil?)
      self.keywords = []
    end
    if(keywords.include?(keyword))
      return
    end

    self.keywords << keyword
    db_entry = Keyword.where(word: keyword).first()

    if(db_entry.nil?)
      db_entry = Keyword.create! :word => keyword, :artifacts => [], :artifact_collections => []
    end

    db_entry.artifact_collections << self
  end

  def remove_keyword(keyword)
    if(self.keywords.nil?)
      self.keywords = []
    end

    self.keywords.delete(keyword)

    db_entry = Keyword.where(word: keyword).first()
    if(not db_entry.nil?)
      db_entry.artifact_collections.delete(self)
    end
  end
end
