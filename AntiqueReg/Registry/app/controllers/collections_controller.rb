class CollectionsController < ApplicationController
  before_filter :signed_in_user

  layout 'userLayout'

  def new
    @user = current_user
    @artifacts = params[:artifact] || []
    @collection = ArtifactCollection.new
  end

  def create
    collection = ArtifactCollection.new(params[:artifact_collection])
    if collection.valid?
      current_user.artifact_collections << collection
      collection.save
    end
    redirect_to controller: 'users', action: 'collections', id: current_user.id
  end

  def edit
    @user = current_user
    @collection = ArtifactCollection.find(params[:id])
    @image = ['http://cdn-static.zdnet.com/i/story/60/23/000818/arrowhead.jpg',
              'http://placehold.it/400x200&text=two',
              'http://placehold.it/300x350&text=three',
              'http://placehold.it/600x550&text=four',
              'http://placehold.it/400x300&text=five',
              'http://placehold.it/800x350&text=six',
              'http://placehold.it/600x550&text=seven',
              'http://placehold.it/100x100&text=eight',
              'http://placehold.it/500x400&text=nine',
              'http://placehold.it/200x3s50&text=ten']
    @description = 'This is an arrowhead found during the development process'
    @keywords = ['Arrowhead', 'Old', 'Grey']
  end

  def update
    old_collection = ArtifactCollection.find(params[:id])
    old_collection.update_attributes(params[:artifact_collection])
    old_collection.save!
    redirect_to controller: 'users', action: 'collections', id: current_user.id
  end

  def destroy
    collection = ArtifactCollection.find(params[:id])
    collection.enabled = false
    collection.save!
    redirect_to controller: 'users', action: 'collections', id: current_user.id
  end

  def info
    @user = current_user
    @collection = ArtifactCollection.find(params[:id])
    @image = ['http://cdn-static.zdnet.com/i/story/60/23/000818/arrowhead.jpg',
              'http://placehold.it/400x200&text=two',
              'http://placehold.it/300x350&text=three',
              'http://placehold.it/600x550&text=four',
              'http://placehold.it/400x300&text=five',
              'http://placehold.it/800x350&text=six',
              'http://placehold.it/600x550&text=seven',
              'http://placehold.it/100x100&text=eight',
              'http://placehold.it/500x400&text=nine',
              'http://placehold.it/200x3s50&text=ten']
    @description = 'This is an arrowhead found during the development process'
    @keywords = ['Arrowhead', 'Old', 'Grey']
  end
end