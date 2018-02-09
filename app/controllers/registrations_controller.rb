class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    UserMailer.sign_up_confirmation_email(resource.email).deliver_now
    new_onboarding_path
  end

  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :current_password)
  end

end