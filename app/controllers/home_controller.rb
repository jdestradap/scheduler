class HomeController < ApplicationController
  before_filter :authenticate_patient!

  private

  def authenticate_patient!
    unless user_signed_in? && current_user.role_type.eql?("Patient")
      redirect_to root_path, notice: "You must be a patient to go here"
    end
  end
end
