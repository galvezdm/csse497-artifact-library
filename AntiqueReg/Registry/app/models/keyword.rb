#DO NOT ADD OR REMOVE KEYWORDS THROUGH ANYTHING ON THIS CLASS
#That will be handled through calls on Artifacts and ArtifactCollections
#Only use this class to search on keywords
class Keyword
  include Mongoid::Document
  field :word
  has_and_belongs_to_many :artifacts, :inverse_of => nil
  has_and_belongs_to_many :artifact_collections, :inverse_of => nil

  #Passing in nil wil return nothing.  Use the fields for
  #getting everything.
  def get_visible_collections(user)
    all = self.artifact_collections
    visible = []

    if(user.nil?)
      return visible
    end


    all.each do |collection|
      if collection.is_visible(user)
        visible << collection
      end
    end

    return visible
  end

  #Passing in nil wil return nothing.  Use the fields for
  #getting everything.
  def get_visible_artifacts(user)
    all = self.artifacts

    visible = []

    if(user.nil?)
      return visible
    end


    all.each do |artifact|
      if artifact.is_visible(user)
        visible << artifact
      end
    end

    return visible
  end
end