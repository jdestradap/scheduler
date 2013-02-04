class Appointment < ActiveRecord::Base
  attr_accessible :start_date, :doctor_id, :patient_id
  attr_reader :doctor_name

  validates_associated :doctor, :patient
  validates_presence_of :doctor_id, :patient_id, :start_date
  validate :start_date_past
  validates_uniqueness_of :start_date, scope: [:doctor_id]
  validates_uniqueness_of :start_date, scope: [:patient_id]

  belongs_to :doctor
  belongs_to :patient

  def appointment_doctors
    Doctor.all.map do |doctor|
      {label: doctor.first_name, value: doctor.id}
    end
  end

  private

  def start_date_past
    if(!start_date.blank? and start_date < DateTime.now)
      errors.add(:start_date, "can't be in the past")
    end
  end
end
