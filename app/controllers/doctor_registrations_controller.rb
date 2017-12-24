class DoctorRegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    resource.verified = false
    resource.save
    new_doctor_onboarding_path
  end

  private

  def sign_up_params
    params.require(:doctor).permit(:title, :first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:doctor).permit(:title, :first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end