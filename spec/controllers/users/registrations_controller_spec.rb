require "spec_helper"

describe Users::RegistrationsController do
  include Devise::TestHelpers
  let(:patient) { double.as_null_object }
  let(:params) { {patient: {first_name: "Juanchini", last_name: "Estrada",
                  user_attributes: {email: "juanchi@sjsj.com",
                  password: "123123", password_confirmation: "123123"}}} }

  before  do
    request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "redirects to the appointments_path" do
      patient = Patient.new(params[:patient])
      Patient.stub(new: patient)
      expect(patient.save).to be_true
      post 'create'
      response.should redirect_to appointments_path
    end
  end
end