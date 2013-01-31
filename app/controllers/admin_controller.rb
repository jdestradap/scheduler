class AdminController < ApplicationController
  before_filter :authenticate_admin!

  private

  def authenticate_admin!
    unless user_signed_in? && current_user.role_type.eql?("admin")
      redirect_to root_path, notice: "You must be an admin to go here"
    end
  end
end