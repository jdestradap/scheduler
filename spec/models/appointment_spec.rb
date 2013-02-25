require "spec_helper"

describe Appointment do
  context "the appointment is valid" do
    let(:doctor) { FactoryGirl.create(:doctor) }
    let(:patient) { FactoryGirl.create(:patient) }
    let(:appointment) { FactoryGirl.build(:appointment, doctor: doctor, patient: patient) }

    describe "when a patient creates a valid appointment" do
      it "returns true" do

        expect(appointment.save).to be_true
      end
    end

    describe "when there is an appointment at the same time, with a different doctor and patient" do
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

    describe "when the appointment starts in a doctor unavailable hour" do
      let(:doctor) { FactoryGirl.create(:doctor) }

      it "returns false" do
        FactoryGirl.create(:time_slot, start_date: Date.today, start_time: Time.now, end_time: Time.now + 30.minutes, doctor: doctor)
        appointment = FactoryGirl.build(:appointment, doctor: doctor, start_date: DateTime.now)
        expect(appointment.save).to be_false
      end
    end

    describe "When the appointment starts in a doctor unavailable recurrent hour" do
      let(:doctor) { FactoryGirl.create(:doctor) }

      it "returns false" do
        start_date = Date.today
        start_time = Time.now
        end_time = start_time + 50.minutes
        start_date_appointment = start_time.to_datetime + 1.day
        schedule_rule = Scheduler::ScheduleRecurrency.new({start_time: start_time, end_time: end_time}).schedule_to_hash
        FactoryGirl.create(:time_slot, start_date: start_date, start_time: start_time, end_time: end_time, doctor: doctor, schedule_rule: schedule_rule)
        appointment = FactoryGirl.build(:appointment, doctor: doctor, start_date: start_date_appointment - 5.hours)
        expect(appointment.save).to be_false
      end
    end
  end
end