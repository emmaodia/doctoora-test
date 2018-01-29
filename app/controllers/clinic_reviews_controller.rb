class ClinicReviewsController < ApplicationController

	def new
		@clinic_review = ClinicReview.new
		@clinic_id = params[:clinic_id]
		@clinic_name = Clinic.find(params[:clinic_id]).name
		@user_id = current_user.id
		@rating_scale = [1,2,3,4,5]
	end

	def create

		@clinic_review = ClinicReview.new(review_params)

		if @clinic_review.save
			flash[:notice] = "Thanks. Your clinic review has been saved"
			redirect_to root_path
		else
			flash[:notice] = "There has been a problem submitting your review"
			render 'new'
		end
	end

	private

	def review_params
		params.require(:clinic_review).permit(:cleanliness, :customer_service, :noise_level, :comfort, :overall, :clinic_id, :user_id)
	end
end