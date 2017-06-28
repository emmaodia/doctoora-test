class DoctorProfileController < ApplicationController

	def show
		@doctor = Doctor.find(current_doctor.id)
	end
end