class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @patient = Patient.new
    @patient.build_user
  end

  def create
    @patient = Patient.new(params[:patient])
    if @patient.save
      if @patient.user.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, @patient.user)
        respond_with @patient, :location => after_sign_up_path_for(@patient.user)
      else
        set_flash_message :notice, :"signed_up_but_#{@patient.user.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with @patient, :location => after_inactive_sign_up_path_for(@patient.user)
      end
    else
      clean_up_passwords @patient
      respond_with @patient
    end
  end
end
