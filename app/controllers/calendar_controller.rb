class CalendarController < ApplicationController
  before_filter :authenticate_doctor!

  def index

    if(current_user.role_type.eql?("Admin") and params[:doctor_id].present?)
      @appointments = Doctor.find(params[:doctor_id]).appointments
      @doctor_id = params[:doctor_id]
    else
      @appointments = Doctor.find(current_user.role_id).appointments
      @doctor_id = current_user.role_id
    end

    @appointments_by_date = @appointments.group_by {|i| i.start_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private

  def authenticate_doctor!
    unless user_signed_in? && (current_user.role_type.eql?("Doctor") || current_user.role_type.eql?("Admin"))
      redirect_to root_path, notice: "You must be a doctor to go here"
    end
  end
end