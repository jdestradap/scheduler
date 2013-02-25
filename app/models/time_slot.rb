class TimeSlot < ActiveRecord::Base
  attr_accessible :doctor_id, :start_date, :start_time, :end_time, :schedule_rule, :recurrent
  validates_associated :doctor
  validates_presence_of :doctor_id, :start_date, :start_time, :end_time
  validate :start_date_past, :start_time_after_end_time, :doctor_already_set_unavailable_hour
  validates_uniqueness_of :doctor_id, :scope => [:start_date, :start_time]
  belongs_to :doctor
  serialize :schedule_rule, Hash

  after_validation :create_schedule_rule

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
    if(time_slot_reserved or time_slot_reserved_recurrently)
      errors.add(:start_time, "You have already set unavailable hour(s) in this time slot")
    end
  end

  def time_slot_reserved
    doctor_by_id.doctor_availability(start_date, start_time, end_time)
  end

  def time_slot_reserved_recurrently
    doctor_by_id.doctor_availability_recurring(start_time, end_time)
  end

  def doctor_by_id
    Doctor.find doctor_id
  end

  def create_schedule_rule
    if(start_time.present? && end_time.present? && recurrent)
      self.schedule_rule = Scheduler::ScheduleRecurrency.new({start_time: start_time, end_time: end_time}).schedule_to_hash
    end
  end
end
