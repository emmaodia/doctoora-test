class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	protected

  	def notify! user_id, notifier_id, notification_text
		Notification.create!(user_id: user_id, doctor_id: notifier_id, notification: notification_text)
  	end

 #  	def send_message sender_id, recipient_id, message
	# 	if Conversation.between(current_doctor.id, user_id).present?
	# 		conversation = Conversation.between(current_doctor.id, user_id).first
 # 		else
 #  			conversation = Conversation.create!(sender_id: current_doctor.id, recipient_id: user_id)
 # 		end

	# 	conversation.messages.create!(body: message, 
	# 		messageable_id: current_doctor.id, messageable_type: :Doctor)
	# end

end
