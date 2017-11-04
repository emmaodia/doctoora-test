class OnboardingController < ApplicationController

	def new
		@user = User.find(current_user.id)
	end

	def create
		@user = User.find(current_user)
		@user.bmi = ((onboarding_params[:weight].to_i/onboarding_params[:height].to_f)/onboarding_params[:height].to_f)
    	@user.update(onboarding_params)
    	redirect_to onboarding_new_additional_info_path
	end

	def additional_info
		@user = User.find(current_user.id)
	end

	def submit_additional_info
		@user = User.find(current_user.id)
		@user.update(additional_params)
		flash[:notice] = "Welcome to Doctoora. You have been onboarded successfully."
		redirect_to root_path
	end

	private
	
	def onboarding_params
		params.require(:user).permit(:dob, :gender, :ethnicity, :phone, :house, :town, :postcode, :country,
									 :height, :weight, :bmi, :vaccinations, :avatar, :allergies, :medication,
									 :lasting_conditions)
	end

	def additional_params
		params.require(:user).permit(:allergies, :medication, :lasting_conditions, :recreational_drug,
									:dietary_restrictions, :alcohol_consumption, :tobacco, :exercise)
	end
	
end