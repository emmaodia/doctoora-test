class DoctorReviewsController < ApplicationController

	def new
		@doctor_review = DoctorReview.new
		@doctor_id = params[:doctor_id]
		@consultation_id = params[:consultation_id]
		@consultation_date = Consultation.find(@consultation_id).date
		@user_id = current_user.id
		@rating_scale = [1,2,3,4,5]
	end

	def create
		@doctor_review = DoctorReview.new(review_params)
		consultation = Consultation.find @doctor_review.consultation_id

		if @doctor_review.save
			flash[:notice] = "Thanks. Your health provider review has been saved"
			notify! current_user.id, @doctor_review.doctor_id, "You have submitted a new health provider review", "You have received a new review", "/", "/"
			if consultation.tool == "Clinic Visit"
				redirect_to clinic_review_path(consultation.clinic_id)
			else
				redirect_to root_path
			end
		else
			flash[:notice] = "There has been a problem submitting your review"
			render 'new'
		end
	end

	private

	def review_params
		params.require(:doctor_review).permit(:explanation_clarity, :courtesy, :listening, :punctuality, 
			:doctor_id, :user_id, :consultation_id)
	end
end