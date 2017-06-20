class ProfileController < ApplicationController

	def show
		@user = User.find(current_user.id)
	end

	def edit
		@user_profile = User.find(params[:id])
	end

	def update
		@user_profile = User.find(params[:id])
		@user_profile.bmi = ((profile_params[:weight].to_i/profile_params[:height].to_f)/profile_params[:height].to_f)
    	@user_profile.update(profile_params)
    	flash[:notice] = "Profile edited successfully"
    	redirect_to profile_path(params[:id])
	end

	private

	def profile_params
		params.require(:user).permit(:dob, :gender, :ethnicity, :house, :town, :postcode, :country, :height, :weight, :bmi, :vaccinations, :avatar)
	end

end