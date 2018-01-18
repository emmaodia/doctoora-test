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

		consultation = Consultation.find @consultation_id
		consultation.completed = true
		consultation.save
		
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
			redirect_to patient_review_examination_findings_path(patient_review)
		else
			flash[:notice] = "Your patient review could not be submitted"
			redirect_to 'new'
		end
	end

	def examination_findings
		@review = PatientReview.find(params[:id])
	end

	def submit_examination_findings
		review = PatientReview.find(params[:id])
		review.update(examination_findings_params)

		if review.save
			flash[:notice] = "Review submitted for patient"
			notify! review.user_id, current_doctor.id, "You have received a patient review from",
			"You have successfully submitted a patient review for", "/profile/<%= user_id %>", "/patient_reviews"
			redirect_to root_path
		else
			flash[:notice] = "Problem encountered submitting review"
			render 'new'
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
			:associated_complaint_1, :associated_complaint_2, :associated_complaint_3, :alcohol_consumption)
	end

	def examination_findings_params
		params.require(:patient_review).permit(:temperature, :pulse_rate, :physical_exam, :mental_exam, :problems_list, :differential_diagnosis,
			:investigations, :final_diagnosis, :comment, :prescription_name, :prescription_dosage, :prescription_regimen, :prescription_duration)
	end

end