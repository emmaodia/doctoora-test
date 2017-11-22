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
			@doctors = Doctor.get_professional_type @specialization
		end

		@clinics = Clinic.all
	end

	def create
		doctor = Doctor.find(consultation_params[:professional])

		if is_doctor_booked? doctor, consultation_params
			flash[:notice] = "#{doctor.title} #{doctor.first_name} #{doctor.last_name} is already booked for this time"
			@consultation = current_user.consultations.new
			render 'new'
		else
			@consultation = current_user.consultations.new(consultation_params)
			@consultation.doctor_id = consultation_params[:professional]
			@consultation.date_and_time = Time.new(@consultation.date.year, @consultation.date.month, @consultation.date.day,
  									   			   @consultation.time.hour, @consultation.time.min).to_datetime
			if @consultation.save
				redirect_to consultation_payment_path(@consultation)
			else
				flash[:notice] = "There was an error creating your consultation"
				@consultation = current_user.consultations.new
				render 'new'
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
		@consultation = Consultation.find(params[:id])
		if @consultation.payment_method == "Credit Card"
			amount = 5000
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: @consultation.doctor_id)
			redirect_to initialize_transaction amount, current_user.email

			#if transaction.plan_id is nil then transaction is a consultation booking and therefore
			#transaction.doctor_id refers to the doctor the consultation is booked with
		end
	end

	private

	def consultation_params
		params.require(:consultation).permit(:discipline, :address, :service, :tool, :date, :time, :end_time, :professional, :clinic_id, :payment_method)
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

end