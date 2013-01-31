require "spec_helper"

describe Admin::PatientsController do
	before { controller.stub(authenticate_admin!: true) }
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
end

