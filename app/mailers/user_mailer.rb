class UserMailer < ApplicationMailer

	default from: 'chidumaga@gmail.com'

	def refer_email username, email
		@username = username
		mail(to: email, subject: "Doctoora referral by #{username} ")
	end
end
