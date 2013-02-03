require "spec_helper"

describe TimeSlotsController do
	before { controller.stub(authenticate_doctor!: true) }
  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
end