class Admin::PatientsController < AdminController
  def index
    @patients = Patient.all
  end

  def new
    @patient = Patient.new
    @patient.build_user
  end

  def edit
    @patient = Patient.find(params[:id])
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
    @patient = Patient.find(params[:id])

    respond_to do |format|
      if @patient.update_attributes(params[:patient])
        format.html { redirect_to admin_patient_path, notice: t('flash.patient_created') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to admin_patients_url }
      format.json { head :no_content }
    end
  end
end
