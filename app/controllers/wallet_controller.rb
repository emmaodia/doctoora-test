class WalletController < ApplicationController
	include PaystackHelper

	def show
		@user = User.find params[:id]
		@transaction = @user.transactions.new
	end

	def top_up
		@user = User.find params[:user_id]

		@transaction = @user.transactions.new(transaction_params)
		@transaction.save

		redirect_to initialize_transaction @transaction.amount, @user.email
	end

	def pay_from_wallet
		if current_user
			wallet = current_user.wallet
		elsif current_doctor
			wallet = current_doctor.wallet
		end
		
		wallet_balance = wallet.balance
		amount = params[:amount].to_i
		if wallet_balance >= amount
			flash[:notice] = "Transaction successful. You have paid ₦#{amount}."
			wallet.balance -= amount
			wallet.save
			redirect_to root_path
		else
			flash[:notice] = "There are insufficient funds in your wallet"
			redirect_to root_path
		end
	end

	private

	def transaction_params
		params.require(:transaction).permit(:amount, :purpose)
	end

end