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
		sender = params[:sender_id]
		recipient = params[:recipient_id]

		p params[:sender_id]
 		p params[:recipient_id]
 		p params[:body]

		if Conversation.between(sender, recipient).present?
			@conversation = Conversation.between(sender,
     		recipient).first
 		else
  			@conversation = Conversation.create!(conversation_params)
 		end

 		@conversation.messages.create(body: params[:body])

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