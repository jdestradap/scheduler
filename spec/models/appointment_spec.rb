require "spec_helper"

describe Appointment do
  describe "when a patient creates a valid appointment" do
    let(:doctor) { FactoryGirl.create(:doctor)}
    let(:patient) { FactoryGirl.create(:patient)}
    let(:appointment) { FactoryGirl.build(:appointment, doctor: doctor, patient: patient)}

    it "returns true" do
      expect(appointment.save).to be_true
    end

    describe "when there is an appointment at the same time, with a different doctor and patient" do
      let(:doctor) { FactoryGirl.create(:doctor) }
      let(:patient) { FactoryGirl.create(:patient) }

      it "returns true" do
        start_date = DateTime.now + 1.year
        appointment = FactoryGirl.create(:appointment, doctor: doctor, patient: patient, start_date: start_date)
        second_appointment = FactoryGirl.build(:appointment, start_date: start_date)
        expect(second_appointment.save).to be_true
      end
    end
  end

  context "the appointment is invalid" do
    describe "when the appointment is in the past" do
      let(:appointment) { FactoryGirl.build(:appointment, start_date: DateTime.new(2013,02,03,10,30,00,'-5')) }

      it "returns false" do
        expect(appointment.save).to be_false
      end
    end

    describe "when a patient book an appointment at the same start_date" do
      let(:doctor) { FactoryGirl.create(:doctor) }
      let(:patient) { FactoryGirl.create(:patient) }

      it "returns false" do
        start_date = DateTime.now + 1.year
        appointment = FactoryGirl.create(:appointment, doctor: doctor, patient: patient, start_date: start_date)
        second_appointment = FactoryGirl.build(:appointment, patient: patient, start_date: start_date)
        expect(second_appointment.save).to be_false
      end
    end

    describe "when a doctor have an appointment at the same start_date" do
      let(:doctor) { FactoryGirl.create(:doctor) }
      let(:patient) { FactoryGirl.create(:patient) }

      it "returns false" do
        start_date = DateTime.now + 1.year
        appointment = FactoryGirl.create(:appointment, doctor: doctor, patient: patient, start_date: start_date)
        second_appointment = FactoryGirl.build(:appointment, doctor: doctor, start_date: start_date)
        expect(second_appointment.save).to be_false
      end
    end

    describe "when the appointment starts between another appointment" do
      let(:doctor) { FactoryGirl.create(:doctor) }
      let(:patient) { FactoryGirl.create(:patient) }

      start_date = DateTime.now + 30.minutes
      second_start_date = start_date + 29.minutes

      it "returns false" do
        appointment = FactoryGirl.create(:appointment, doctor: doctor, patient: patient, start_date: start_date)
        second_appointment = FactoryGirl.build(:appointment, doctor: doctor, patient: patient, start_date: second_start_date)
        expect(second_appointment.save).to be_false
      end
    end
  end
end