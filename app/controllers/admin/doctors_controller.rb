class Admin::DoctorsController < AdminController
  def index
    @doctors = Doctor.all
  end

  def show
    @doctors = Doctor.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render json: admin_doctor_path }
    end
  end

  def new
    @doctor = Doctor.new
    @doctor.build_user
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def create
    @doctor = Doctor.new(first_name: params[:doctor][:first_name],
                         last_name: params[:doctor][:last_name])

    @doctor.build_user(email: params[:doctor][:user_attributes][:email],
    	                 password: params[:doctor][:user_attributes][:password])
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
        format.html { redirect_to admin_doctor_path, notice: t('flash.doctor_updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy

    respond_to do |format|
      format.html { redirect_to admin_doctors_url }
      format.json { head :no_content }
    end
  end
end
