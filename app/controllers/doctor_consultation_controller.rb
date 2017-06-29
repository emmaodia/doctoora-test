class DoctorConsultationController < ApplicationController

	def index
		@consultations = current_doctor.consultations.all
	end
end