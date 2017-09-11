module ApplicationHelper

	def get_doctor_name id
		doctor = Doctor.find(id)
		return "Dr. " + doctor.first_name + " " + doctor.last_name
	end

	def get_patient_name id
		patient = User.find(id)
		return patient.first_name + " " + patient.last_name
	end
	
end
