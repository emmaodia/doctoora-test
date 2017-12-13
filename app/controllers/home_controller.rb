class HomeController < ApplicationController

	def index
		if user_signed_in?
			@cards = Card.where('page = ?', 'Home')
			@user = current_user
			@past_appointments = Consultation.where("date_and_time <= ? AND user_id = ?", Time.now, @user.id)
			@upcoming_appointments = Consultation.where("date_and_time >= ? AND user_id = ?", Time.now, @user.id)
		elsif doctor_signed_in?
			@doctor = current_doctor
			date = Date.today
			@wallet_balance = Wallet.find_by_doctor_id(@doctor.id).balance
			@upcoming_appointments = @doctor.consultations.where('date_and_time >= ? AND date_and_time <= ? AND status =?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day, "accepted")
			@appointment_requests = @doctor.consultations.where('status = ?', 'pending')
			@past_appointments = @doctor.consultations.where('date_and_time < ?', Time.zone.now.beginning_of_day)
		end
	end
	
	def knowledgebase
		@cards = Card.where('page = ?', 'Knowledgebase')
	end

	def render_refer_form
	end

	def refer
		flash[:notice] = "Thank you for your referral! An email has been sent to #{params[:email]}"
		if current_user.first_name && current_user.last_name
			username = current_user.first_name + " " + current_user.last_name
		else
			username = "a Doctoora User"
		end
		mail = UserMailer.refer_email username, params[:email]
		mail.deliver_now

		redirect_to '/'
	end

	def noted
		Notification.find(params[:id]).delete
		redirect_to :back
	end

end
