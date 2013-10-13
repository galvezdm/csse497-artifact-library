require 'spec_helper'

describe UsersController do

  describe "POST create" do
    before(:each) do
      @user = FactoryGirl.build_stubbed(:users)
    end

    def post_create
      post :create, users: {}
    end

    context "with valid attributes" do
      before(:each) do
        @user.stub(:valid?).and_return(true)
        @user.stub(:save)
        User.stub(:new).and_return(@user)
      end

      it " creates a new user" do
        @user.should_receive(:save)
        post_create
      end
    end

    context "with invalid attributes" do
      before(:each) do
        @user.stub(:valid?).and_return(false)
        User.stub(:new).and_return(@user)
      end

      it "doesn't create a new user" do
        @user.should_not_receive(:save)
        post_create
      end
    end
  end

  describe "GET #collections" do
    before :each do
      @user = FactoryGirl.build_stubbed(:users)
      User.stub(:find).and_return(@user)
    end

    def getCollections
      get :collections
    end

    context "for a user getting their own collections" do
      it "gets all of the collections" do
        @user.should_receive(:collections)
        getCollections
      end
    end
  end

  describe "GET #friends" do
    before :each do
      @user = FactoryGirl.build_stubbed(:users)
      User.stub(:find).and_return(@user)
    end

    def getFriends
      get :friends
    end

    context "for a user getting their own friends" do

      it "gets all of the friends" do
        @user.should_receive(:friends)
        getFriends
      end
    end
  end
end