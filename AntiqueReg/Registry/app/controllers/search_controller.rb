class SearchController < ApplicationController
  layout 'userLayout'
  def show
    terms = params[:keyword].split()
    @current_page = params[:page].to_i
    stemmed_terms = Artifact.stem(terms)
    artifact_ids = current_user.artifacts.map(&:id)
    accessible_artifacts = ArtifactSearchIndex.where(:artifact_id.in => artifact_ids)
    matched_ids = []
    stemmed_terms.each do |term|
      matched_ids.concat(accessible_artifacts.where("search_terms.term" => term).map(&:artifact_id))
    end

    @all = Artifact.find(matched_ids)
    @artifacts = @all.each_slice(10).to_a.at(@current_page-1)
    @pages = @all.count/10 + 1
    @items_per_page = 1


  end
end
