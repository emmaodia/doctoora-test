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

	def create
		sender = params[:sender_id]
		recipient = params[:recipient_id]

		if Conversation.between(sender, recipient).present?
			@conversation = Conversation.between(sender,
     		recipient).first
 		else
  			@conversation = Conversation.create!(conversation_params)
 		end

 		# redirect_to conversation_messages_path(@conversation)
	end

	private
 	
 	def conversation_params
  		params.permit(:sender_id, :recipient_id)
 	end

end