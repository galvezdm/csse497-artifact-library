require "spec_helper"

describe Collection do

  before(:each) do
    @owner = FactoryGirl.build(:users)
  end

  let(:collection){
    collection = Collection.new(name: "Guerri Pueblo Collection")
    collection.owner = @owner
    collection
  }

  subject{collection}

  it{should respond_to(:name)}
  it "should be owned by the defined user" do
    collection.owner.should ==  @owner
  end

end