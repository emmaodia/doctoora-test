class ProfileController < ApplicationController
	include PaystackHelper

	def show
		@notifications = current_user.notifications.last(5).reverse if current_user
		@user = User.find(params[:id] || current_user.id)
		@patient_reviews = @user.patient_reviews.all.order(created_at: :desc)
	end

	def edit
		@lgas = User::LGAS
		@states = User::STATES
		@user_profile = User.find(params[:id])
	end

	def update
		@user_profile = User.find(params[:id])
		@user_profile.bmi = ((profile_params[:weight].to_i/profile_params[:height].to_f)/profile_params[:height].to_f)
    	@user_profile.update(profile_params)
    	flash[:notice] = "Profile edited successfully"
    	redirect_to profile_path(params[:id])
	end

	def destroy
		@patient = User.find(params[:id])
    	@patient.destroy
    	flash[:notice] = "User account deleted successfully"
    	redirect_to :back
	end

	private

	def profile_params
		params.require(:user).permit(:dob, :gender, :ethnicity, :phone, :house, :town, :state, :postcode, :country,
									 :height, :weight, :bmi, :vaccinations, :avatar, :allergies, :medication,
									 :lasting_conditions)
	end

end