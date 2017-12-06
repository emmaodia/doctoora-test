class DoctorOnboardingController < ApplicationController

	def new
		@lgas = User::LGAS
		@doctor = Doctor.find(current_doctor.id)
		
		@clinical_specialty_list = Doctor::CLINICAL_SPECIALTY_LIST

		@non_clinical_specialty_list = Doctor::NON_CLINICAL_SPECIALTY_LIST
	end

	def create
		@doctor = Doctor.find(current_doctor)
    	@doctor.update(onboarding_params)
    	redirect_to root_path
	end

	def upload_documents
		@doctor = Doctor.find(current_doctor.id)
	end

	def submit_documents
		doctor = Doctor.find(current_doctor.id)
		doctor.update(doctor_params)

		if doctor.save
			redirect_to root_path
		else
			flash[:notice] = "There was an error saving your information"
			render 'upload_documents'
		end
	end

	private

	def onboarding_params
		params.require(:doctor).permit(:dob, :gender, :ethnicity, :specialization, :specialty, 
									   :house, :town, :postcode, :country, :avatar, :registration_fee,
									   :consultation_fee, :clinic_visit_fee)
	end

	def doctor_params
		params.require(:doctor).permit(:mdcn, :nysc, :uni_cert, :post_nysc, :id_proof)
	end

end