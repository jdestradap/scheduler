class TimeSlotsController < ApplicationController
  before_filter :authenticate_doctor!

  def index
  end

  def new
    @time_slot = TimeSlot.new
  end

  def create
  end

  private

  def authenticate_doctor!
    unless user_signed_in? && current_user.role_type.eql?("Doctor")
      redirect_to root_path, notice: "You must be a doctor to go here"
    end
  end
end