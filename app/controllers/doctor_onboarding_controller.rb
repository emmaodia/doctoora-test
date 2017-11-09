class DoctorOnboardingController < ApplicationController

	def new
		@doctor = Doctor.find(current_doctor.id)
		
		@specialty_list = ["Aesthetic Practitioner", "Cardiologist", "Cardiothoracic Surgery", "Dental", "Dermatology", 
		"General Practitioner", "General Surgery", "Haematology", "Mental Health General Practitioner", "Nephrology", "Neurology", "Neurosurgery",
		"Obstetrics and Gynecology", "Oncology", "Orthopaedic Surgery", "Paediatric Oncology", "Paediatric Surgery",
		"Paediatrics", "Psychiatry", "Renal Surgery", "Respirology", "Urology"]
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
									   :house, :town, :postcode, :country, :height, :weight, :avatar)
	end

	def doctor_params
		params.require(:doctor).permit(:mdcn, :nysc, :uni_cert, :post_nysc, :id_proof)
	end

end