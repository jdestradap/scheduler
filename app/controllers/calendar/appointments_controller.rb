class Calendar::AppointmentsController < CalendarController
  def show
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: @appointment }
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to calendar_appointments_url }
      format.json { head :no_content }
    end
  end
end
