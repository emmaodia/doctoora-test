class DoctorOnboardingController < ApplicationController

	def new
		@doctor = Doctor.find(current_doctor.id)
		p @doctor
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
			redirect_to doctor_onboarding_new_upload_documents_path
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
		assign_values params["doctor"], doctor

		if doctor.save
			redirect_to doctors_path
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

end