require "spec_helper"

describe SessionsController do

  describe "POST create" do

    before(:each) do
      @user = FactoryGirl.build_stubbed(:users)
      User.stub(:where).and_return([@user])
    end

    def post_create
      post :create, session: {password: 'correct'}
    end

    context "with invalid credentials" do
      before(:each) do
        @user.stub(:authenticate).with('correct').and_return(false)
        post_create
      end

      it "states there is an invalid email/password" do
        flash.now[:error].should == 'Invalid email/password combination'
      end

    end

    context "with valid credentials" do
      before(:each) do
        @user.stub(:authenticate).with('correct').and_return(true)
        post_create
      end

      it "signs the user in" do
        SessionsController.any_instance.should_receive(:sign_in).with(@user)
        post_create
      end

    end
  end
end