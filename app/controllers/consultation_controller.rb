class ConsultationController < ApplicationController
	include PaystackHelper

	def index
		@consultations = current_user.consultations.where("status = ?", "accepted").order(date: :desc)
	end

	def type_select
		@specializations = Consultation::SPECIALIZATIONS
	end

	def new
		@consultation = current_user.consultations.new

		if params[:type] == "care team"
			if current_user.care_team
				@doctors = []
				CareTeam.find_by_user_id(current_user.id).doctor_ids.each do |doctor_id|
					@doctors << Doctor.find(doctor_id)
				end
				@specialization = nil
			else
				flash[:notice] = "Add a doctor to your care team to book this kind of consultation"
				redirect_to care_path
			end
		else
			@specialization = params[:type].capitalize
			@specialization = "Non-Clinical" if params[:type] == "non-clinical"
			@doctors = Doctor.get_available_professionals_of_type @specialization
		end

		@clinics = Clinic.all
	end

	def create
		doctor = Doctor.find(consultation_params[:professional])

		if is_doctor_booked? doctor, consultation_params
			flash[:notice] = "#{doctor.title} #{doctor.first_name} #{doctor.last_name} is already booked for this time"
			redirect_to :back
		else
			@consultation = current_user.consultations.new(consultation_params)
			@consultation.doctor_id = consultation_params[:professional]
			@consultation.date_and_time = Time.new(@consultation.date.year, @consultation.date.month, @consultation.date.day,
  									   			   @consultation.time.hour, @consultation.time.min).to_datetime
			@consultation.status = :pending
			if @consultation.save
				redirect_to consultation_payment_path(@consultation)
			else
				flash[:notice] = "There was an error creating your consultation"
				redirect_to :back
			end
		end
	end

	def show
		@consultation = Consultation.find(params[:id])
	end

	def edit
		@consultation = Consultation.find(params[:id])
	end

	def update
		@consultation = Consultation.find(params[:id])
    	@consultation.update(consultation_params)

    	redirect_to consultation_index_path
	end

	def destroy
		@consultation = consultation.find(params[:id])
    	@consultation.destroy
    	flash[:notice] = "Your consultation has been deleted successfully"
    	redirect_to consultation_index_path
	end

	def payment
		consultation = Consultation.find(params[:id])
		doctor = Doctor.find(consultation.professional.to_i)

		payment_method = consultation.payment_method
		amount = get_consultation_fee doctor, consultation

		if payment_method == "Pay With Card"
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: doctor.id, purpose: :consultation)
			redirect_to initialize_transaction amount, current_user.email
		elsif payment_method == "Doctoora Wallet"
			redirect_to pay_from_wallet_path(amount)
		elsif payment_method == "Insurance"
			Transaction.create!(user_id: current_user.id, doctor_id: doctor.id, amount: amount, purpose: :insurance, status: :processing)
			flash[:notice] = "Thank you #{current_user.first_name}. Your consultation request has been sent and will be verified."
			redirect_to root_path
		elsif payment_method == "Pay In Clinic"
			Transaction.create!(user_id: current_user.id, doctor_id: doctor.id, amount: amount, purpose: :pay_in_clinic, status: :processing)
			flash[:notice] = "Thank you #{current_user.first_name}. Your consultation request has been sent and will be verified."
			redirect_to root_path
		end
	end

	private

	def consultation_params
		params.require(:consultation).permit(:discipline, :address, :service, :tool, :date, :time, :end_time, :professional, :clinic_id, :payment_method, :user_notes)
	end

	def is_doctor_booked? doctor, current_consultation
		doctor.consultations.each do |consultation|
			if consultation.date == Date.parse(current_consultation[:date])
				#time(4i) & time(5i) represent the hr and min values of the new booking
				#converts new booking time to <2000-01-01 17:00:00> format as this is how db saves it
				consultation_time = Time.new(2000, 1, 1, current_consultation["time(4i)"].to_i, 
											current_consultation["time(5i)"].to_i)
				if consultation.time.to_i == consultation_time.to_i
					return true
				end
			end
		end
		return false
	end

	def get_consultation_fee doctor, consultation
		if consultation.tool == "Video Call"
			return doctor.video_consultation_fee
		elsif consultation.tool == "Home Visit"
			return doctor.home_consultation_fee
		elsif consultation.tool == "Clinic Visit"
			return doctor.clinic_visit_fee
		end
	end

end