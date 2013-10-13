require 'spec_helper'

describe ArtifactController do


  describe "POST create" do
    before(:each) do
      @artifact = FactoryGirl.build_stubbed(:artifact)
    end

    def post_create
      post :create, artifact: {}
    end

    context "with valid attributes" do
      before(:each) do
        @artifact.stub(:valid?).and_return(true)
        @artifact.stub(:save)
        Artifact.stub(:new).and_return(@artifact)
      end

      it "creates a new artifact" do
        @artifact.should_receive(:save)
        post_create
      end
    end
    context "with invalid attributes" do
      before(:each) do
        @artifact.stub(:valid?).and_return(false)
        Artifact.stub(:new).and_return(@artifact)
      end

      it "doesn't create a new artifact" do
        @artifact.should_not_receive(:save)
      end
    end
  end
end