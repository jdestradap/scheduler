require "spec_helper"

describe ApplicationController do
  controller do
    def after_sign_in_path_for(resource)
      super resource
    end
  end

  describe "After sigin-in" do
    describe "When user is an admin" do
      let(:resource) { double(role_type: "Admin") }
      it "redirects to the admin page" do
        expect(controller.after_sign_in_path_for resource).to eq admin_path
      end
    end

    describe "When user is a doctor" do
      let(:resource) { double(role_type: "Doctor") }
      it "redirects to the calendar page" do
        expect(controller.after_sign_in_path_for resource).to eq calendar_path
      end
    end

    describe "When user is a patient" do
      let(:resource) { FactoryGirl.build_stubbed(:user) }
      it "redirects to the appointments page" do
        expect(controller.after_sign_in_path_for resource).to eq appointments_path
      end
    end
  end
end