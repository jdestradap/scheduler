class CalendarController < ApplicationController
  before_filter :authenticate_doctor!

  def index
    @appointments = Doctor.find(current_user.role_id).appointments
    @appointments_by_date = @appointments.group_by {|i| i.start_date.to_date}
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  private

  def authenticate_doctor!
    unless user_signed_in? && current_user.role_type.eql?("Doctor")
      redirect_to root_path, notice: "You must be a doctor to go here"
    end
  end
end