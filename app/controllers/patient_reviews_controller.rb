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
		@consultation_id = params[:consultation_id]
		@latest_patient_review = @user.patient_reviews.last if @user.patient_reviews
		@review = PatientReview.new

		@lgas = ["Agege", "Ajeromi Ifelodun", "Alimosho", "Amuwo-Odofin", "Apapa", "Badagry", "Kosofe", "Mushin", "Oshodi Isolo", "Ojo",
			"Ikorodu", "Surulere", "Ifako-Ijaye", "Shomolu", "Lagos Mainland", "Ikeja", "Eti-osa", "Lagos Island", "Epe", "Ibeju Lekki"]

		@religions = ["Christian", "Buddhist", "Hindu", "Jewish", "Muslim", "Sikh", "Traditional (Please state below)", "Any other religion (Please state below)", "No Religion"]

		@education = ["None", "High School (SSCE)", "OND (Ordinary National Diploma)" ,"NCE (Nigeria Certificate in Education)", "Diploma", "HND (Higher National Diploma)", "Bachelors", "Honors", "Masters", "Doctorate"]

		@occupation= ["Academic", "Accounting/Finance", "Admin/Secretarial", "Advertising", "Architect/Design"]
	end

	def create
		user_id = params[:user_id]
		user = User.find user_id
		patient_review = user.patient_reviews.new(patient_review_params)

		if patient_review.save
			flash[:notice] = "Review submitted for patient"
			notify! user_id, current_doctor.id, "You have received a new patient review from",
			"You have successfully submitted a new patient review for", "/profile/<%= user_id %>", "/patient_reviews"
			redirect_to root_path
		else
			flash[:notice] = "Your patient review could not be submitted"
			redirect_to 'new'
		end
	end

	def show
		@review = PatientReview.find params[:id]
		@review_user_id = User.find @review.user_id
	end

	def destroy
	end

	private

	def patient_review_params
		params.require(:patient_review).permit(:review, :doctor_id, :consultation_id, :lga, :religion, :religion_detailed, :occupation,
			:education, :hpi, :medical_history, :drug_history, :family_history, :surgical_history, :drug_reaction,
			:allergic_reaction, :blood_transfusions, :smoking, :recent_travel, :travel_destination, :sexual_history, :chief_complaint,
			:associated_complaint_1, :associated_complaint_2, :associated_complaint_3)
	end

end