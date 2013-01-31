class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def after_sign_in_path_for(resource)
    if resource.role_type.eql?("doctor")
      calendar_index_path
    elsif resource.role_type.eql?("admin")
      admin_path
    elsif resource.role_type.eql?("patient")
      home_index_path
    end
  end
end