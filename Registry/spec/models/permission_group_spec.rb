require 'spec_helper'

describe PermissionGroup do

  before(:each) do
    first_friend = FactoryGirl.build(:users)
    second_friend = FactoryGirl.build(:users, first_name:"Joe")
    third_friend = FactoryGirl.build(:users, first_name: "Irene")
    @friends = [first_friend, second_friend, third_friend]
  end

  let(:permission_group){
    group = PermissionGroup.new()
    group.users = @friends
    group
  }

  it "holds multiple users" do
    permission_group.users.should == @friends
  end
end