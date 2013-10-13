class UsersController < ApplicationController
  layout :resolve_layout
  before_filter :signed_in_user, except: [:create, :validate_invite]

  def validate_invite
    if request.post?
      if params[:invitationCode] == '1r4gor4'
        session[:invited] = true
        render json: {success: true}
      else
        render json: {success: false, message: 'Invalid invitation code'}
      end
    end
  end

  def create
    if request.post?
      if params[:user][:password] != params[:user][:password]
        render json: {success: false, message: 'password and confirmation do not match'}
      elsif !params[:terms]
        render json: {success: false, message: 'user must accept terms and conditions'}
      else
        params[:user].delete('confirm_password')
        user = User.new(params[:user])
        if  user.valid?
          if !params[:picture].nil?
            user.add_avatar(params[:picture])
          end
          user.save
          render json: {success: true}
        else
          render json: {success: false, message: user.errors}
        end
      end
    else
      if session[:invited]
        render 'users/signup', layout: 'application'
      else
        redirect_to root_url
      end
    end
  end

  def show
    @user = User.find(params[:id])
    @permission_groups = current_user.permission_groups
    @profile_class = 'user-main-pic'
    render 'users/_profile', layout: 'profileLayout'
  end

  def collections
    @user = User.find(params[:id])
    @title = 'Collections'
    if !params[:is_friend].nil?
      @title = @user.name + '\'s Collection'
    end
    @collections = @user.artifact_collections.where(:enabled => true)

    @collections_per_page = 5
    @current_page = params[:page].to_i
    @pages = @collections.count/@collections_per_page + 1
  end

  def friends
    @user = User.find(params[:id])
    @friends = @user.friends
    render :json => @friends
  end

  def artifacts
    @artifacts = current_user.artifacts.where(:enabled => true).to_a
    items_per_page = 20
    @parsedArtifacts = @artifacts.each_slice(items_per_page).to_a
  end

  def edit
    if !params[:user].nil?
      current_user.update_attributes(params[:user])
      sign_in(current_user)
      redirect_to controller: 'users', action:'show', id: current_user.id
    end

    if !params[:picture].nil?
      current_user.update_avatar(params[:picture])
    end
  end

  private

  def signed_in_user
    redirect_to root_url, notice: 'Please sign in.' unless signed_in?
  end

  def resolve_layout
    case action_name
      when 'edit'
        'profileLayout'
      else
        'userLayout'
    end
  end
end