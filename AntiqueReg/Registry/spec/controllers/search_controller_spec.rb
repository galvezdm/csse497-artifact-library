require 'spec_helper'

describe SearchController do
  describe "GET 'show'" do
    it "returns http success" do
      controller.stub_chain(:current_user,:permission_group).and_return([])

      get :show, query: "mackinaw point"
      response.should be_success
    end
  end

end
