class ApplicationController < ActionController::Base
	include PaystackHelper
	# Prevent CSRF attacks by raising an exception.
  	# For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception

  	protected

  	def notify! user_id, notifier_id, notification_text, dr_notification_text, link, dr_link, email_content="You have received a new notification on Doctoora"
		Notification.create!(user_id: user_id, doctor_id: notifier_id, notification: notification_text,
			dr_notification_msg: dr_notification_text, link: link, dr_link: dr_link)

		UserMailer.notification_email(email_content, User.find(user_id).email).deliver_now
		UserMailer.notification_email(email_content, Doctor.find(notifier_id).email).deliver_now
  	end

  	def notify_admin! notification_text, user_class, user_id
  		AdminNotification.create!(notification_text: notification_text, user_class: user_class, user_id: user_id)
  	end

  	def make_payment payment_method, amount, doctor_id, reason_for_payment, success_message="transaction successful!"
  		if payment_method == "Pay With Card"
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: doctor_id, purpose: reason_for_payment)
			redirect_to initialize_transaction amount, current_user.email
		elsif payment_method == "Doctoora Wallet"
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: doctor_id, purpose: reason_for_payment)
			redirect_to pay_from_wallet_path(amount)
		elsif payment_method == "Insurance"
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: doctor_id, purpose: reason_for_payment)
			flash[:notice] = success_message
			redirect_to root_path
			return true
		elsif payment_method == "Pay In Clinic"
			current_user.transactions.create(amount: amount, plan_id: nil, status: :processing, doctor_id: doctor_id, purpose: reason_for_payment)
			flash[:notice] = success_message
			redirect_to root_path
			return true
		end
  	end

  	def make_payment_dr payment_method, amount, doctor_id, reason_for_payment, success_message="transaction successful!"
  		if payment_method == "Pay With Card"
			current_doctor.transactions.create(amount: amount, plan_id: nil, status: :processing, purpose: reason_for_payment)
			redirect_to initialize_transaction amount, current_doctor.email
		elsif payment_method == "Doctoora Wallet"
			current_doctor.transactions.create(amount: amount, plan_id: nil, status: :processing, purpose: reason_for_payment)
			redirect_to pay_from_wallet_path(amount, reason_for_payment)
		elsif payment_method == "Insurance"
			current_doctor.transactions.create(amount: amount, plan_id: nil, status: :processing, purpose: reason_for_payment)
			flash[:notice] = success_message
			redirect_to root_path
		elsif payment_method == "Pay In Clinic"
			current_doctor.transactions.create(amount: amount, plan_id: nil, status: :processing, purpose: reason_for_payment)
			flash[:notice] = success_message
			redirect_to root_path
		end
	end
end
