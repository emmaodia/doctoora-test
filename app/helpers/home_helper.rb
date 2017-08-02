module HomeHelper
	def get_doctor_name id
		doctor = Doctor.find(id)
		return "Dr. " + doctor.first_name + " " + doctor.last_name
	end

	def get_doctor_avatar id
		doctor = Doctor.find(id)
		return doctor.avatar.url(:medium)
	end

end
