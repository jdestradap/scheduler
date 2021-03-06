class Appointment < ActiveRecord::Base
  attr_accessible :start_date, :doctor_id, :patient_id
  attr_reader :doctor_name

  validates_presence_of :doctor_id, :patient_id, :start_date, :end_date
  validate :start_date_past, :appointment_availability
  validates_uniqueness_of :start_date, scope: :doctor_id
  validates_uniqueness_of :start_date, scope: :patient_id

  belongs_to :doctor
  belongs_to :patient

  before_validation :update_end_time

  scope :previous_appointments, where('start_date < ?', DateTime.now)
  scope :current_appointments, where('start_date >= ?', DateTime.now)

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
    if(doctor_has_appointment? or patient_has_appointment? or doctor_availability? or doctor_availability_recurring?)
      errors.add(:start_date, "this date is not available")
    end
  end

  def doctor_availability?
    if (doctor_id.present?)
      doctor_by_id.doctor_availability(start_date.to_date, start_date.to_time, end_date.to_time)
    else return end
  end

  def doctor_availability_recurring?
    if(doctor_id.present?)
      doctor_by_id.doctor_availability_recurring(start_date.to_time, end_date.to_time)
    else return end
  end

  def doctor_by_id
    Doctor.find(doctor_id)
  end

  def patient_by_id
    Patient.find(patient_id)
  end

  def doctor_has_appointment?
    if (doctor_id.present?)
      exist_an_appointment(doctor_by_id)
    else return end
  end

  def patient_has_appointment?
    exist_an_appointment(patient_by_id)
  end

  def exist_an_appointment(instance)
    not instance.appointments.find(:first, conditions: ["(end_date > ? AND start_date < ?)", start_date, end_date]).nil?
  end

  def update_end_time
    unless start_date.nil?
      self.end_date = start_date + 30.minutes
    end
  end
end
