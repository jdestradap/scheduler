class AppointmentsController < ApplicationController
  before_filter :authenticate_patient!

  def index
    if(current_user.role_type.eql?("Admin") and params[:patient_id].present?)
      @appointments = Patient.find(params[:patient_id]).appointments.current_appointments
      @previous_appointments = Patient.find(params[:patient_id]).appointments.previous_appointments
      @patient_id = params[:patient_id]
    else
      @appointments = Patient.find(current_user.role_id).appointments.current_appointments
      @previous_appointments = Patient.find(current_user.role_id).appointments.previous_appointments
      @patient_id = current_user.role_id
    end
  end

  def new
    @patient_id = params[:patient_id]
    @appointment = Appointment.new
  end

  def create
    params[:appointment].delete(:doctor_name)
    @appointment = Appointment.new(params[:appointment])
    if @appointment.save
      redirect_to appointments_path(patient_id: "#{@appointment.patient_id}"), notice: t('flash.appointment_created')
    else
      @patient_id = @appointment.patient_id
      render "new"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_url(patient_id: "#{@appointment.patient_id}")
  end

  private

  def authenticate_patient!
    unless user_signed_in? && (current_user.role_type.eql?("Patient") || current_user.role_type.eql?("Admin"))
      redirect_to root_path, notice: "You must be a patient to go here"
    end
  end
end
