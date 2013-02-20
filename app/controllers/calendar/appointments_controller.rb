class Calendar::AppointmentsController < CalendarController
  before_filter :get_appointment, only: [:show, :destroy]

  def show
    @doctor_id = @appointment.doctor_id
    respond_to do |format|
      format.html
      format.json { render json: @appointment }
    end
  end

  def destroy
    AppointmentMailer.appointment_canceled_notification(@appointment).deliver
    @appointment.destroy
    redirect_to calendar_appointments_url
  end

  private

  def get_appointment
    @appointment = Appointment.find(params[:id])
  end
end
