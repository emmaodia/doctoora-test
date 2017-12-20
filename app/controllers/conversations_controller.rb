class ConversationsController < ApplicationController

	# before_action :authenticate_user || :authenticate_doctor
	
	def index
		@users = User.all
		if user_signed_in?
			@conversations = Conversation.where("recipient_id=?", current_user.id).order(created_at: :desc)
		elsif doctor_signed_in?
			@conversations = Conversation.where("sender_id=?", current_doctor.id).order(created_at: :desc)
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
 			@conversation.messages.create(body: params[:body], image: params[:conversation][:image], user_class: "Doctor", user_id: current_doctor.id)
 			@conversation.unread_messages = true
 			@conversation.save
 		elsif user_signed_in?
 			@conversation.messages.create(body: params[:body], image: params[:conversation][:image], user_class: "Patient", user_id: current_user.id)
 			@conversation.sender_unread_messages = true
 			@conversation.save
 		end

 		redirect_to conversations_path
	end

	def show
		@conversation = Conversation.find(params[:id])
		@messages = @conversation.messages.order(created_at: :desc)

		if user_signed_in?
			@conversation.unread_messages = false
			@conversation.save
		elsif doctor_signed_in?
			@conversation.sender_unread_messages = false
			@conversation.save
		end

		@message = @conversation.messages.new
	end

	private
 	
 	def conversation_params
  		params.permit(:sender_id, :recipient_id)
 	end

end