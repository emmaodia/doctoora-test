class PatientReviewsController < ApplicationController

	def index
		@patients = []
		reviews  = PatientReview.where("doctor_id=?", current_doctor.id)

		reviews.each do |review|
			@patients << User.find(review.user_id)
			@patients.uniq!
		end
	end

	def new
		@user = User.find(params[:user_id])
		@user_name = @user.first_name + " " + @user.last_name
		@review = PatientReview.new
	end

	def create
		user = User.find(params[:user_id])
		patient_review = user.patient_reviews.new(patient_review_params)

		if patient_review.save
			flash[:notice] = "Review submitted for patient"
			redirect_to root_path
		else
			flash[:notice] = "Your patient review could not be submitted"
			redirect_to 'new'
		end
	end

	def destroy
	end

	private

	def patient_review_params
		params.require(:patient_review).permit(:review, :doctor_id)
	end

end