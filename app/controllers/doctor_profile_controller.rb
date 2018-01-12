class DoctorProfileController < ApplicationController

	def show
		@doctor = Doctor.find(params[:id] || current_doctor.id)
	end

	def edit
		@doctor_profile = Doctor.find(params[:id])
		@lgas = User::LGAS
		@states = User::STATES
		@clinical_specialty_list = Doctor::CLINICAL_SPECIALTY_LIST
		@non_clinical_specialty_list = Doctor::NON_CLINICAL_SPECIALTY_LIST
	end

	def update
		@doctor_profile = Doctor.find(params[:id])
    	@doctor_profile.update(doctor_profile_params)
    	flash[:notice] = "Profile edited successfully"
    	redirect_to doctor_profile_path(params[:id])
	end

	def destroy
		@doctor = Doctor.find(params[:id])
    	@doctor.destroy
    	flash[:notice] = "Doctor account deleted successfully"
    	redirect_to :back
	end

	def toggle_availability
		@doctor = Doctor.find params[:id]
		@doctor.available = !@doctor.available
		@doctor.save
		redirect_to :back
	end

	def doctor_profile_params
		params.require(:doctor).permit(:dob, :gender, :specialization, :specialty, 
			:ethnicity, :house, :town, :state, :postcode, :country, :avatar, :registration_fee,
			:consultation_fee, :clinic_visit_fee)
	end

end