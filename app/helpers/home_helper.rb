module HomeHelper

	def get_doctor_avatar id
		doctor = Doctor.find(id)
		return doctor.avatar.url(:medium)
	end

end
