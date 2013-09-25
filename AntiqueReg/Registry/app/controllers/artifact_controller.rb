class ArtifactController < ApplicationController
  layout 'userLayout'

  def index
  end


  def destroy
    artifact = Artifact.find(params[:id])
    artifact.enabled = false
    artifact.save!
    redirect_to controller: 'users', action: 'artifacts', id: current_user.id
  end

  def create
    if (params[:id].empty?)
      #Create
      artifact = Artifact.new(params[:artifact])

      params[KEYWORDS].split(',').each do |k|
        artifact.add_keyword(k)
      end

      artifact.owner = current_user

      if artifact.valid?
        artifact.save
      end

      artifact.add_picture(params[:cover], true, 'cover')

      unless params[:pictures].nil?
        params[:pictures].each_with_index do |picture, index|
          artifact.add_picture(picture, false, index.to_s)
        end
      end
    else
      #Edit
      artifact = Artifact.find(params[:id])
      #artifact.update_attributes(params[:artifact])

      if !params[:cover].nil?
        artifact.delete_picture(artifact.get_cover)
        artifact.add_picture(params[:cover], true, 'cover')
      end

      if !params[:pictures].nil?
        picture_to_keep = Array.new
        new_pictures = Array.new
        params[:pictures].each do |picture|
          if picture.is_a?(String)
            picture_to_keep.push(picture)
          else
            new_pictures.push(picture)
          end
        end

        max_index = 0

        puts 'picture to include is' + picture_to_keep.to_s
        artifact.get_pictures.each do |p|
          puts 'pid is '+p.id
          if ! picture_to_keep.include?(p.id.to_s)
            max_index = [max_index, p.order_number.to_i].max
            artifact.delete_picture(p)
          end
        end

        new_pictures.each_with_index do |p, index|
          artifact.add_picture(p, false, (index+max_index+1).to_s)
        end
      end
    end

    redirect_to controller: 'artifact', action:'show', id: artifact.id
  end

  def show
    @artifact = Artifact.find(params[:id])
    @pictures = @artifact.get_pictures
    @cover = @artifact.get_cover
  end

  def new
    @collections = current_user.artifact_collections
    @current_collection_id = params[:collection_id]
    @edit = false
    if (params[:id].nil?)
      @artifact = Artifact.new
      @permission_groups = %w(Group1 Group2 Group3)
    else
      @edit = true
      @artifact = Artifact.find(params[:id])
      @pictures = @artifact.get_pictures
      @cover = @artifact.get_cover
    end
  end

end