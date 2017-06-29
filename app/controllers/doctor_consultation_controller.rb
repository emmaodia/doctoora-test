class DoctorConsultationController < ApplicationController

	def index
		@consultations = current_doctor.consultations.all
	end

	def accept_consultation
		consultation = Consultation.find(params[:id])
		consultation.status = :accepted
		consultation.save
	end

	def reject_consultation
		consultation = Consultation.find(params[:id])
		consultation.status = :rejected
		consultation.save
	end
end