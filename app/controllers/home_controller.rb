class HomeController < ApplicationController

	def index
		if user_signed_in?
			@user = current_user
			@past_appointments = Consultation.where("date_and_time <= ? AND user_id = ?", Time.now, @user.id)
			@upcoming_appointments = Consultation.where("date_and_time >= ? AND user_id = ?", Time.now, @user.id)
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
	
end
