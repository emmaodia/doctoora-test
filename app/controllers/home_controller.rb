class HomeController < ApplicationController

	def index
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
