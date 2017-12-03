class DoctorProfileController < ApplicationController

	def show
		@doctor = Doctor.find(params[:id] || current_doctor.id)
	end

	def edit
		@doctor_profile = Doctor.find(params[:id])
		@clinical_specialty_list = ["Aesthetic Practitioner", "Cardiologist", "Cardiothoracic Surgery", "Dental", "Dermatology", 
		"General Practitioner", "General Surgery", "Haematology", "Mental Health General Practitioner", "Nephrology", "Neurology", "Neurosurgery",
		"Obstetrics and Gynecology", "Oncology", "Orthopaedic Surgery", "Paediatric Oncology", "Paediatric Surgery",
		"Paediatrics", "Psychiatry", "Renal Surgery", "Respirology", "Urology"]
		@non_clinical_specialty_list = ["Dance Aerobics", "Swimming", "Yoga", "Martial Arts", "Dietetics", "Lifestyle Counseling"]
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
			:ethnicity, :house, :town, :postcode, :country, :avatar, :registration_fee,
			:consultation_fee, :clinic_visit_fee)
	end

end