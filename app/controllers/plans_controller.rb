class PlansController < ApplicationController
	include PaystackHelper

	def index
		if user_signed_in?
			@plans = Plan.where('category = ?', 'Patient')
		elsif doctor_signed_in?
			@plans = Plan.where('category = ?', 'Doctor')
		end
	end

	def clinics
		@clinics = Clinic.all
	end

	def book_clinic
		@clinic = Clinic.find params[:id]
		@clinic_rental = ClinicRental.new
	end

	def rent_clinic
		clinic = Clinic.find params[:id]

		make_payment_dr clinic_rental_params[:payment_method], clinic.rental_cost, current_doctor.id, "transaction"

		@clinic_rental = current_doctor.clinic_rentals.new(clinic_rental_params)
		@clinic_rental.date_and_time = Time.new(@clinic_rental.date.year, @clinic_rental.date.month, @clinic_rental.date.day,
  									   			@clinic_rental.time.hour, @clinic_rental.time.min).to_datetime
		@clinic_rental.clinic_id = clinic.id

		if @clinic_rental.save
			flash[:notice] = "Thank you, you have successfully booked #{clinic.name}"
		else
			flash[:notice] = "Clinic could not be rented"
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

		if transaction.purpose == "clinic_rental"
			#redirected here from clinic_rental_controller#payment
			flash[:notice] = "Thank you. Your clinic_rental request has been sent and will be verified"
			notify! current_user.id, transaction.doctor_id, "You have requested a clinic_rental with",
			"You have received a new clinic_rental request from", "/clinic_rental", "/doctor_clinic_rental"
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

	private

	def clinic_rental_params
		params.require(:clinic_rental).permit(:date, :time, :payment_method)
	end

end
