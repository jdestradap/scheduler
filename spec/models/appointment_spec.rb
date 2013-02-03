require "spec_helper"

describe Appointment do
  describe "when a patient creates an appointment and is valid" do
    let(:doctor) { FactoryGirl.create(:doctor)}
    let(:patient) { FactoryGirl.create(:patient)}
    let(:appointment) { FactoryGirl.build(:appointment, doctor: doctor, patient: patient)}

    it "returns true" do
      expect(appointment.save).to be_true
    end
  end
end