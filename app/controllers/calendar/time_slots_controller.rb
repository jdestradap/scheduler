class Calendar::TimeSlotsController < CalendarController
  def index
    @doctor_id = params[:doctor_id]
  end

  def new
    @time_slot = TimeSlot.new
    @doctor_id = params[:doctor_id]
  end

  def create
    @time_slot = TimeSlot.new(params[:time_slot])
    if @time_slot.save
      redirect_to calendar_time_slots_path(doctor_id: "#{@time_slot.doctor_id}"), notice: t('flash.time_slot_created')
    else
      render "new"
    end
  end
end