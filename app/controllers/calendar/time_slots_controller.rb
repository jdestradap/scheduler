class Calendar::TimeSlotsController < CalendarController
  def index
  end

  def new
    @time_slot = TimeSlot.new
  end

  def create
    @time_slot = TimeSlot.new(params[:time_slot])

    if @time_slot.save
      redirect_to calendar_time_slots_path, notice: t('flash.time_slot_created')
    else
      render "new"
    end
  end
end