require "spec_helper"

describe AppointmentsController do
  let(:user) { double(role_id: double.as_null_object, role_type: "Patient") }
  let(:patient) { double(appointments: double(current_appointments: [double.as_null_object],
                        previous_appointments: [double.as_null_object]),
                        patient_id: double.as_null_object) }

  before do
    controller.stub(authenticate_patient!: true, current_user: user)
  end

  describe "GET 'index'" do
    before do
      Patient.stub(:find).and_return(patient)
    end

    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end
end

