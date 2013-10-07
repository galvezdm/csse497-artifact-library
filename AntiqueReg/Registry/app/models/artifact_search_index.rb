class ArtifactSearchIndex
  include Mongoid::Document

  field :artifact_id
  embeds_many :search_terms

  index "search_terms" => 1
end