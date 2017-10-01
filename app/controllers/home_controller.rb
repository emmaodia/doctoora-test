class HomeController < ApplicationController

	def index
		if user_signed_in?
			@user = current_user
			@past_appointments = Consultation.where("date_and_time <= ? AND user_id = ? AND status = ?", Time.now, @user.id, "accepted")
			@upcoming_appointments = Consultation.where("date_and_time >= ? AND user_id = ? AND status = ?", Time.now, @user.id, "accepted")
		elsif doctor_signed_in?
			@doctor = current_doctor
			date = Date.today
			@upcoming_appointments = @doctor.consultations.where('date_and_time >= ? AND status =?', Time.zone.now.beginning_of_day, "accepted")
		end
	end
	
	def knowledgebase
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

	private

	def is_today appt_time
		p appt_time.today?
		return appt_time.today?
	end
	
end
