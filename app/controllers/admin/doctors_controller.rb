class Admin::DoctorsController < AdminController
  before_filter :get_doctor, only: [:edit, :update, :destroy]

  def index
    @doctors = Doctor.all
  end

  def new
    @doctor = Doctor.new
    @doctor.build_user
  end

  def edit
  end

  def create
    @doctor = Doctor.new(params[:doctor])
    if @doctor.save
      redirect_to admin_doctors_path, notice: t('flash.doctor_created')
    else
      render "new"
    end
  end

  def update
    if @doctor.update_attributes(params[:doctor])
      redirect_to admin_doctor_path, notice: t('flash.doctor_updated')
    else
      render action: "edit"
    end
  end

  def destroy
    @doctor.destroy
    redirect_to admin_doctors_url
  end

  private

  def get_doctor
    @doctor = Doctor.find(params[:id])
  end
end
