module DoctorConsultationHelper

	def get_patient_name id
		patient = User.find(id)
		return patient.first_name + " " + patient.last_name
	end

end