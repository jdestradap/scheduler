class AppointmentMailer < ActionMailer::Base
  default from: "from@example.com"

  def appointment_canceled_notification(appointment)
    @appointment = appointment
    @patient = Patient.find(appointment.patient_id)
    @doctor = Doctor.find(appointment.doctor_id)
    mail to: @patient.user.email, subject: "Appointment canceled notification."
  end
end
