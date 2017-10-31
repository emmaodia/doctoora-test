class ConversationsController < ApplicationController

	# before_action :authenticate_user || :authenticate_doctor
	
	def index
		@users = User.all
		if user_signed_in?
			@conversations = Conversation.where("recipient_id=?", current_user.id)
		elsif doctor_signed_in?
			@conversations = Conversation.where("sender_id=?", current_doctor.id)
		end

 	end

 	def new
 		@doctors = Doctor.where("verified=?", true)
 		@patients = User.all

 		@conversation = Conversation.new
 	end

	def create
		sender = params["conversation"]["sender_id"]
		recipient = params["conversation"]["recipient_id"]

		if Conversation.between(sender, recipient).present?
			@conversation = Conversation.between(sender,
     		recipient).first
 		else
  			@conversation = Conversation.create!(sender_id: sender.to_i, recipient_id: recipient.to_i)
 		end

 		if doctor_signed_in?
 			@conversation.messages.create(body: params[:body], user_class: "Doctor", user_id: current_doctor.id)
 		else
 			@conversation.messages.create(body: params[:body], user_class: "User", user_id: current_user.id)
 		end

 		redirect_to conversations_path
	end

	def show
		@conversation = Conversation.find(params[:id])
		@conversation.unread_messages = false
		@conversation.save

		@message = @conversation.messages.new
	end

	private
 	
 	def conversation_params
  		params.permit(:sender_id, :recipient_id)
 	end

end