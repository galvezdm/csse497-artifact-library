class FriendsController < ApplicationController
  before_filter :signed_in_user

  layout 'userLayout'
  def index
    @user = User.find(params[:id])
    @friends = @user.friends
  end

  def show
    @user = User.find(params[:id])
    @friend = User.find(params[:friend_id])
  end

  def collections

  end

  def artifacts

  end
end