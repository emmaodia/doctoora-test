module DoctorConsultationHelper

	def get_patient_name id
		patient = User.find(id)
		return patient.first_name + " " + patient.last_name
	end


	def my_profile?
		if !current_doctor
			return false
		end
		return current_doctor.id == params[:id].to_i
	end

end