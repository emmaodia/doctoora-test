module ApplicationHelper

	def get_doctor_name id
		doctor = Doctor.find(id)
		return "Dr. " + doctor.first_name + " " + doctor.last_name
	end
	
end
