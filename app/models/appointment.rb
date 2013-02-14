class Appointment < ActiveRecord::Base
  attr_accessible :start_date
  attr_reader :doctor_name

  validates_associated :doctor, :patient
  validates_presence_of :doctor_id, :patient_id, :start_date, :end_date
  validate :start_date_past, :appointment_availability
  validates_uniqueness_of :start_date, scope: :doctor_id
  validates_uniqueness_of :start_date, scope: :patient_id

  belongs_to :doctor
  belongs_to :patient

  before_validation :update_end_time

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

  def appointment_availability
    if(doctor_has_appointment? or patient_has_appointment?)
      errors.add(:start_date, "this date is not available")
    end
  end

  def doctor_has_appointment?
  	doctor = Doctor.find(doctor_id)
    exist_an_appointment(doctor)
  end

  def patient_has_appointment?
    patient = Patient.find(patient_id)
    exist_an_appointment(patient)
  end

  def exist_an_appointment(instance)
    not instance.appointments.find(:first, :conditions => ["(end_date > ? AND end_date <= ?)",
                                                           start_date, end_date]).nil?
  end

  def update_end_time
    unless start_date.nil?
      self.end_date = start_date + 30.minutes
    end
  end
end