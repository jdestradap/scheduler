class Appointment < ActiveRecord::Base
  validates_associated :doctor, :patient

  belongs_to :doctor
  belongs_to :patient
end
