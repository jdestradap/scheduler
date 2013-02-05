class AppointmentsController < ApplicationController
  before_filter :authenticate_patient!

  def index
    @appointments = Appointment.all
  end

  def new
    @appointment = Appointment.new
  end

  def create
    start_date = DateTime.new(params[:appointment]["start_date(1i)"].to_i,
                              params[:appointment]["start_date(2i)"].to_i,
                              params[:appointment]["start_date(3i)"].to_i,
                              params[:appointment]["start_date(4i)"].to_i,
                              params[:appointment]["start_date(5i)"].to_i)

    @appointment = Appointment.new(start_date: start_date)

    @appointment.doctor = Doctor.find(params[:appointment][:doctor_id])
    @appointment.patient = Patient.find(params[:appointment][:patient_id])

    if @appointment.save
      redirect_to appointments_path, notice: t('flash.appointment_created')
    else
      render "new"
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to appointments_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_patient!
    unless user_signed_in? && current_user.role_type.eql?("Patient")
      redirect_to root_path, notice: "You must be a patient to go here"
    end
  end
end
