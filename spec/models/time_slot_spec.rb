require "spec_helper"

describe TimeSlot do
  describe "When a doctor submit a time slot" do
    context "the time slot is invalid" do
      describe "when the start_date is in the past" do
        let(:time_slot) { FactoryGirl.build(:time_slot, start_date: Date.today - 1.day) }
        it "returns false" do
          expect(time_slot.save).to be_false
        end
      end

      describe "when the start time is after the end time" do
        let(:time_slot) { FactoryGirl.build(:time_slot, start_time:Time.now + 10.minutes, end_time: Time.now - 10.minutes) }
        it "returns false" do
          expect(time_slot.save).to be_false
        end
      end

      describe "the time slot is already set" do
        let(:doctor) { FactoryGirl.create(:doctor) }

        it "returns false" do
          start_date = Date.today
          start_time = Time.now
          end_time = start_time + 20.minutes
          time_slot = FactoryGirl.create(:time_slot, start_date: start_date, start_time: start_time, end_time: end_time, doctor: doctor)
          second_time_slot = FactoryGirl.build(:time_slot, start_date: start_date, start_time: start_time + 2.minutes, end_time: end_time + 2.minutes, doctor: doctor)
          expect(second_time_slot.save).to be_false
        end
      end
    end
  end

  describe "When a doctor set a valid recurrence time slot" do
    let(:doctor) { FactoryGirl.create(:doctor) }

    it "retunrs true" do
      start_date = Date.today
      start_time = Time.now
      end_time = start_time + 20.minutes
      schedule_rule = Scheduler::ScheduleRecurrency.new({start_time: start_time, end_time: end_time}).schedule_to_hash
      time_slot = FactoryGirl.build(:time_slot, start_date: start_date, start_time: start_time, end_time: end_time, doctor: doctor, schedule_rule: schedule_rule)
      expect(time_slot.save).to be_true
    end
  end
end
