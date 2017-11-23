class PlansController < ApplicationController
	include PaystackHelper

	def index
		if user_signed_in?
			@plans = Plan.where('category = ?', 'Patient')
		elsif doctor_signed_in?
			@plans = Plan.where('category = ?', 'Doctor')
		end
	end

	def purchase
		amount = Plan.find(params[:id]).price
		if user_signed_in?
			current_user.transactions.create(amount: amount, plan_id: params[:id], status: :processing, purpose: :purchase )
			email = current_user.email
		elsif doctor_signed_in?
			current_doctor.transactions.create(amount: amount, plan_id: params[:id], status: :processing, purpose: :purchase)
			email = current_doctor.email
		end
		redirect_to initialize_transaction amount, email
	end

	def confirm_plan
		transaction = Transaction.where(user_id: current_user.id).last

		transaction.status = :complete
		transaction.save

		user = User.find(current_user.id)

		if transaction.purpose == "consultation"
			#redirected here from consultation_controller#payment
			flash[:notice] = "Thank you. Your consultation request has been sent and will be verified"
			notify! current_user.id, transaction.doctor_id, "You have requested a consultation with",
			"You have received a new consultation request from", "/consultation", "/doctor_consultation"
		elsif transaction.purpose == "purchase"
			user.plan_id = transaction.plan_id
			user.save
			flash[:notice] = "You have successfully purchased a plan"
		elsif transaction.purpose == "topup"
			wallet = user.wallet
			wallet.balance += transaction.amount
			wallet.save
			flash[:notice] = "Wallet successfully topped up"
		end
		redirect_to root_path
	end

end
