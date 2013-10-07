class SearchTerm
  include Mongoid::Document

  field :weight, type: Integer
  belongs_to :permission_group
  field :term, type: String
  embedded_in :artifact_search_index
end