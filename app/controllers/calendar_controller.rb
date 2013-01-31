class CalendarController < ApplicationController
  before_filter :authenticate_doctor!

  private

  def authenticate_doctor!
    unless user_signed_in? && current_user.role_type.eql?("doctor")
      redirect_to root_path, notice: "You must be a doctor to go here"
    end
  end
end
