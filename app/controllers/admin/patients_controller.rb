class Admin::PatientsController < AdminController
  before_filter :get_patient, only: [:edit, :update, :destroy]

  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
    @patient.build_user
  end

  def edit
  end

  def create
    @patient = Patient.new(params[:patient])

    if @patient.save
      redirect_to admin_patients_path, notice: t('flash.patient_created')
    else
      render "new"
    end
  end

  def update
    if @patient.update_attributes(params[:patient])
      redirect_to admin_patient_path, notice: t('flash.patient_created')
    else
      render action: "edit"
    end
  end

  def destroy
    @patient.destroy
    redirect_to admin_patients_url
  end

  private

  def get_patient
    @patient = Patient.find(params[:id])
  end
end
