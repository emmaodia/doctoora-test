class HomeController < ApplicationController

	def index
		if user_signed_in? 
			@cards = Card.where('page = ?', 'Home - Patient') 
		elsif doctor_signed_in?
			@cards = Card.where('page = ?', 'Home - Health Professional')
		end
		
		if user_signed_in?
			@user = current_user
			@past_appointments = Consultation.where("date_and_time <= ? AND user_id = ?", Time.now, @user.id).limit(5)
			@upcoming_appointments = Consultation.where("date_and_time >= ? AND user_id = ? AND status = ?", Time.now, @user.id, "accepted")
			@appointment_requests = Consultation.where("date_and_time >= ? AND user_id = ? AND status = ?", Time.now, @user.id, "pending")
		elsif doctor_signed_in?
			@doctor = current_doctor
			date = Date.today
			@wallet_balance = Wallet.find_by_doctor_id(@doctor.id).balance
			@upcoming_appointments = @doctor.consultations.where('date_and_time >= ? AND date_and_time <= ? AND status =?', Time.zone.now.beginning_of_day, Time.zone.now.end_of_day, "accepted")
			@appointment_requests = @doctor.consultations.where('status = ? AND date_and_time >= ?', 'pending', Time.now)
			@past_appointments = @doctor.consultations.where('date_and_time < ?', Time.zone.now.beginning_of_day).limit(5)
		end

		@admin_notifications_count = AdminNotification.where('noted = ?', false).count

		@card_categories = CardCategory.all
	end
	
	def knowledgebase
		@cards = Card.where('page = ?', 'Knowledgebase')
	end

	def render_refer_form
	end

	def refer
		email = params[:email]
		flash[:notice] = "Thank you for your referral! An email has been sent to #{email}"
		if current_user && (current_user.first_name && current_user.last_name)
			username = current_user.first_name + " " + current_user.last_name
		elsif current_doctor && (current_doctor.first_name && current_doctor.last_name)
			username = current_doctor.first_name + " " + current_doctor.last_name
		else
			username = "a Doctoora User"
		end
		mail = UserMailer.refer_email username, email
		mail.deliver_now

		if current_user
			notify_admin! "New user referral for #{email}", "Patient", current_user.id
		elsif current_doctor
			notify_admin! "New user referral for #{email}", "Doctor", current_doctor.id
		end

		redirect_to '/'
	end

	def noted
		Notification.find(params[:id]).delete
		redirect_to :back
	end

end
