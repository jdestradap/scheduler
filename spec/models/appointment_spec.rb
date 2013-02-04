require "spec_helper"

describe Appointment do
  describe "when a patient creates a valid appointment" do
    let(:doctor) { FactoryGirl.create(:doctor)}
    let(:patient) { FactoryGirl.create(:patient)}
    let(:appointment) { FactoryGirl.build(:appointment, doctor: doctor, patient: patient)}

    it "returns true" do
      expect(appointment.save).to be_true
    end
  end

  context "an appointment is invalid" do
    describe "when a patient creates an appointment with out a doctor" do
      let(:appointment) { FactoryGirl.build(:appointment, doctor_id: nil)}

      it "returns false" do
        expect(appointment.save).to be_false
      end
    end

    context "the appointment start date is invalid" do
      describe "when the appointment start_date is in the past" do
        let(:appointment) { FactoryGirl.build(:appointment, start_date: DateTime.new(2013,02,03,10,30,00,'-5')) }

        it "returns false" do
          expect(appointment.save).to be_false
        end
      end

      describe "when a patient already took an appointment with the same date" do
        let(:doctor) { FactoryGirl.create(:doctor)}
        let(:patient) { FactoryGirl.create(:patient)}

        it "returns false" do

          strart_date = DateTime.now + 1.year
          appointment = FactoryGirl.create(:appointment, doctor: doctor, patient: patient, start_date: strart_date)
          second_appointment = FactoryGirl.build(:appointment, doctor: doctor, patient: patient, start_date: strart_date)
          expect(second_appointment.save).to be_false
        end
      end
    end
  end
end