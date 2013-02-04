class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
    if resource.role_type.eql?("Doctor")
      time_slots_path
    elsif resource.role_type.eql?("Admin")
      admin_path
    elsif resource.role_type.eql?("Patient")
      appointments_path
    end
  end
end