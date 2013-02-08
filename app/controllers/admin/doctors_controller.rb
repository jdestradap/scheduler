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
    @doctor = Doctor.find(params[:id])
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
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      if @doctor.update_attributes(params[:doctor])
        redirect_to admin_doctor_path, notice: t('flash.doctor_updated')
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy

    respond_to do |format|
      redirect_to admin_doctors_url
    end
  end

  private

  def get_doctor
    @doctor = Doctor.find(params[:id])
  end
end
