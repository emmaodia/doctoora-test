class PrescriptionController < ApplicationController

	def new
		@prescription = Prescription.new
		@patient_review = PatientReview.find(params[:patient_review_id])
		@consultation = Consultation.find(@patient_review.consultation_id)
		@consultation_id = @consultation.id
		@user_id = @consultation.user_id
		@doctor_id = @consultation.doctor_id
	end

	def create
		@patient_review = PatientReview.find params[:patient_review_id]
		@prescription = @patient_review.prescriptions.new(prescription_params)

		if @prescription.save
			if params[:commit] == "Add Additional Prescription To This"
				flash[:notice] = "Prescription Added"
				redirect_to new_patient_review_prescription_path(@patient_review.id)
			elsif params[:commit] == "Add This As Final Prescription"
				flash[:notice] = "Prescription Added and Review submitted for patient"
				notify! @patient_review.user_id, current_doctor.id, "You have received a patient review from",
				"You have successfully submitted a patient review for", "/profile/<%= @patient_review.user_id %>", "/patient_reviews"
				redirect_to root_path
			end
		else
			flash[:notice] = "Error saving prescription"
			redirect_to root_path
		end
	end

	private

	def prescription_params
		params.require(:prescription).permit(:name, :dosage, :regimen, :duration, :user_id, :consultation_id, :doctor_id)
	end
end