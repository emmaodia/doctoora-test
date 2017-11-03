class DoctorConsultationController < ApplicationController

	def index
		@consultations = current_doctor.consultations.all
	end

	def accept_consultation
		consultation = Consultation.find(params[:id])

		consultation.status = :accepted
		flash["notice"] = "Consultation has been approved. The patient will be notified"
		consultation.room_name = generate_room_name
		consultation.save

		notify! consultation.user_id, current_doctor.id, "Your consultation booking has been approved by", 
		"You have approved a consultation for", "/consultation", "/doctor_consultation"

		redirect_to doctor_consultation_index_path
	end

	def reject_consultation
		consultation = Consultation.find(params[:id])

		consultation.status = :rejected
		flash["notice"] = "Consultation has been rejected. The patient will be notified"

		notify! consultation.user_id, consultation.doctor_id, "Your consultation booking has been rejected by", 
		"You have rejected a consultation for", "/consultation", "doctor_consultation" #notify before doctor set to nil

		consultation.doctor_id = nil
		consultation.save

		redirect_to doctor_consultation_index_path
	end

	private

	def generate_room_name
		Haikunator.haikunate
	end
end