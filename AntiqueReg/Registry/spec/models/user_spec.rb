require "spec_helper"

describe User do

  it "requires a email" do
    FactoryGirl.build(:users, :email => "").should_not be_valid
  end

  it "requires a phone number" do
    FactoryGirl.build(:users, :phone_number => "").should_not be_valid
  end

  it "requires a address" do
    FactoryGirl.build(:users, :address => "").should_not be_valid
  end

  it "requires a state" do
    FactoryGirl.build(:users, :state => "").should_not be_valid
  end

  it "requires a postal code" do
    FactoryGirl.build(:users, :postal_code => "").should_not be_valid
  end

  it "requires a password" do
    FactoryGirl.build(:users, :password => "").should_not be_valid
  end

  it "authenticates the user with matching username and password" do
    user = FactoryGirl.build(:users, :email => 'frank@gmail.com', :password => 'secret')
    user.authenticate('secret').should == user
  end

  it "does not authenticate the user with mismatching username and password" do
    user = FactoryGirl.build(:users, :email => 'frank@gmail.com', :password => 'secret')
    user.authenticate('incorrect').should == false
  end

  it "creates a remember token before saving" do
    user = FactoryGirl.build(:users)
    user.should_receive(:create_remember_token)
    user.save
  end

end