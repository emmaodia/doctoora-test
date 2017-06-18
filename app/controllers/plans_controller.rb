class PlansController < ApplicationController
	include PaystackHelper

	def index
		@plans = Plan.all
	end

	def purchase
		amount = Plan.find(params[:id]).price
		current_user.transactions.create(amount: amount, plan_id: params[:id], status: :processing)
		redirect_to initialize_transaction amount
	end

	def confirm_plan
		transaction = Transaction.where(user_id: current_user.id).last

		transaction.status = :complete
		transaction.save

		user = User.find(current_user.id)
		user.plan_id = transaction.plan_id
		user.save

		flash[:notice] = "Your have successfully purchased a plan"
		redirect_to root_path
	end

end
