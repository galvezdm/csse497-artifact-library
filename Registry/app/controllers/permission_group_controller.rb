class PermissionGroupController < ApplicationController
  def new
    group = PermissionGroup.new
    group.owner = current_user
    @permission_group = group
  end

  def create
    group = PermissionGroup.new(params[:permission_group])
    if group.valid?
      current_user.permission_groups << group
      current_user.save
      redirect_to controller: 'users', action: 'show', id: current_user.id
    end
  end
end