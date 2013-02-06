class Calendar::TimeSlotsController < CalendarController
  def index
  end

  def new
    @time_slot = TimeSlot.new
  end

  def create
  end
end