class UserMailer < ApplicationMailer

	default from: ENV.fetch("GMAIL_USERNAME")

	def refer_email username, email
		@username = username
		mail(to: email, subject: "Doctoora referral by #{username} ")
	end
end
