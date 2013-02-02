class TimeSlot < ActiveRecord::Base
  has_one :appointment
  belongs_to :doctor
end
