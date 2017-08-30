class DoctorOnboardingController < ApplicationController

	def new
		@doctor = Doctor.find(current_doctor.id)
		@specialty_list = ["Aesthetic Practitioner", "Cardiologist", "Cardiothoracic Surgery", "Dental", "Dermatology", 
		"General Surgery", "Haematology", "Mental Health General Practitioner", "Nephrology", "Neurology", "Neurosurgery",
		"Obstetrics and Gynecology", "Oncology", "Orthopadeic Surgery", "Paediatric Oncology", "Paediatric Surgery",
		"Paediatrics", "Psychiatry", "Renal Surgery", "Respirology", "Urology"]
	end

	def create
		doctor = Doctor.find(current_doctor.id)
		parameters = params["doctor"]

		#save dob as an array and remove it from the params to be iterated over
		doctor.dob = Date.civil(parameters["dob(1i)"].to_i,parameters["dob(2i)"].to_i,parameters["dob(3i)"].to_i)
		
		(0..2).each do
			parameters.shift
		end

		assign_values parameters, doctor
		
		if doctor.save
			redirect_to doctors_path
		else
			flash[:notice] = "There was an error saving your information"
			render 'new'
		end
	end

	def upload_documents
		@doctor = Doctor.find(current_doctor.id)
	end

	def submit_documents
		doctor = Doctor.find(current_doctor.id)
		doctor.update(doctor_params)

		if doctor.save
			flash[:notice] = "Thanks for uploading your documents. They will be verified and you will be contacted soon"
			redirect_to root_path
		else
			flash[:notice] = "There was an error saving your information"
			render 'upload_documents'
		end
	end

	private

	def assign_values params, user
		params.each do |param|
			key = param[0]
			user[key] = param[1]
		end
	end

	def doctor_params
		params.require(:doctor).permit(:mdcn, :nysc, :uni_cert, :post_nysc, :id_proof)
	end

end