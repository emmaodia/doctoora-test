class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	protected

  	def notify! user_id, notifier_id, notification_text, dr_notification_text, link, dr_link
		Notification.create!(user_id: user_id, doctor_id: notifier_id, notification: notification_text,
			dr_notification_msg: dr_notification_text, link: link, dr_link: dr_link)
  	end

end
