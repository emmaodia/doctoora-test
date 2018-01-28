class DoctorProfileController < ApplicationController

	def show
		@doctor = Doctor.find(params[:id] || current_doctor.id)

		reviews = @doctor.doctor_reviews.all
		reviews_length = reviews.length

		@overall = reviews.collect(&:overall).sum.to_f/reviews_length
		@explanation_clarity = reviews.collect(&:explanation_clarity).sum.to_f/reviews_length
		@courtesy = reviews.collect(&:courtesy).sum.to_f/reviews_length
		@listening = reviews.collect(&:listening).sum.to_f/reviews_length
		@punctuality = reviews.collect(&:punctuality).sum.to_f/reviews_length
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
			:home_consultation_fee, :video_consultation_fee, :clinic_visit_fee)
	end

end