class DoctorProfileController < ApplicationController

	def show
		@doctor = Doctor.find(params[:id] || current_doctor.id)
	end

	def edit
		@doctor_profile = Doctor.find(params[:id])
	end

	def update
		@doctor_profile = Doctor.find(params[:id])
    	@doctor_profile.update(doctor_profile_params)
    	flash[:notice] = "Profile edited successfully"
    	redirect_to doctor_profile_path(params[:id])
	end

	def doctor_profile_params
		params.require(:doctor).permit(:dob, :gender, :ethnicity, :house, :town, :postcode, :country, :avatar)
	end

end