class ConsultationController < ApplicationController

	def index
		@consultations = current_user.consultations.all.order(date: :desc)
	end

	def new
		@consultation = current_user.consultations.new
	end

	def create
		doctor = Doctor.find(consultation_params[:professional])

		if is_doctor_booked? doctor, consultation_params
			flash[:notice] = "Dr #{doctor.first_name} #{doctor.last_name} is already booked for this time"
			@consultation = current_user.consultations.new
			render 'new'
		else
			@consultation = current_user.consultations.new(consultation_params)
			@consultation.doctor_id = consultation_params[:professional]

			if @consultation.save
				flash[:notice] = "Your consultation has been booked and will be verified"
				redirect_to root_path
			else
				flash[:notice] = "There was an error creating your consultation"
				@consultation = current_user.consultations.new
				render 'new'
			end
		end
	end

	def show
		@room_name = generate_room_name
		user = User.find(params[:user_id])
		send_user_room_name user, @room_name
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

	private

	def consultation_params
		params.require(:consultation).permit(:discipline, :service, :tool, :date, :start_time, :end_time, :professional)
	end

	def generate_room_name
		Haikunator.haikunate
	end

	def send_user_room_name user, roomname
		if Conversation.between(current_doctor.id, user.id).present?
			conversation = Conversation.between(current_doctor.id, user.id).first
 		else
  			conversation = Conversation.create!(sender_id: current_doctor.id, recipient_id: user.id)
 		end
		conversation.messages.create!(body: roomname, 
			messageable_id: current_doctor.id, messageable_type: :Doctor)
	end

	def is_doctor_booked? doctor, current_consultation
		doctor.consultations.each do |consultation|
			if consultation.date == Date.parse(current_consultation[:date])
				#start_time(4i) & start_time(5i) represent the hr and min values of the new booking
				#converts new booking time to <2000-01-01 17:00:00> format as this is how db saves it
				consultation_time = Time.new(2000, 1, 1, current_consultation["start_time(4i)"].to_i, 
											current_consultation["start_time(5i)"].to_i)
				if consultation.start_time.to_i == consultation_time.to_i
					return true
				end
			end
		end
		return false
	end

end