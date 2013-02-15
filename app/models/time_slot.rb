class TimeSlot < ActiveRecord::Base
  include IceCube
  attr_accessible :doctor_id, :start_date, :start_time, :end_time
  validates_associated :doctor
  validates_presence_of :doctor_id, :start_date, :start_time, :end_time
  validate :start_date_past, :start_time_after_end_time, :doctor_already_set_unavailable_hour
  belongs_to :doctor

  private

  def start_date_past
    if(start_date < Date.today)
      errors.add(:start_date, "can't be in the past")
    end
  end

  def start_time_after_end_time
    if(start_time > end_time)
      errors.add(:start_time, "Can't be after the end time")
    end
  end

  def doctor_already_set_unavailable_hour
    if(time_slot_reserved)
      errors.add(:start_time, "You have already set unavailable hour(s) in this time slot")
    end
  end

  def time_slot_reserved
    not doctor.time_slots.find(:first, conditions: ["(start_date = ? AND end_time > ? AND start_time < ?)", start_date, start_time, end_time]).nil?
  end

  def doctor
    Doctor.find doctor_id
  end
end
