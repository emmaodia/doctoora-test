class ConversationsController < ApplicationController

	# before_action :authenticate_user || :authenticate_doctor
	
	def index
		@users = User.all
		if user_signed_in?
			@conversations = Conversation.where("recipient_id=? OR sender_id=?", current_user.id, current_user.id).order(created_at: :desc)
		elsif doctor_signed_in?
			@conversations = Conversation.where("sender_id=? OR recipient_id=?", current_doctor.id, current_doctor.id).order(created_at: :desc)
		end
 	end

 	def type_select
 		if doctor_signed_in?
 			@user_classes = ["Patient", "Doctor"]
 		elsif user_signed_in?
 			@user_classes = ["Doctor"]
 		end
 	end

 	def new
 		params[:type].capitalize!

 		if params[:type] == "Doctor"
 			if current_doctor
 				@doctors = Doctor.where("verified=? AND id!=?", true, current_doctor.id)
 			else
 				@doctors = Doctor.where("verified=?", true)
 			end
 			@message_to_doctor = true
 		elsif params[:type] == "Patient"
 			@patients = User.all
 			@message_to_doctor = false
 		end

 		@recipient_class = params[:type]

 		if user_signed_in?
 			@sender_class = "Patient"
 			@sender_id = current_user.id
 		elsif doctor_signed_in?
 			@sender_class = "Doctor"
 			@sender_id = current_doctor.id
 		end

 		@conversation = Conversation.new
 	end

	def create
		sender = params["conversation"]["sender_id"]
		recipient = params["conversation"]["recipient_id"]

		if Conversation.between(sender, recipient).present?
			@conversation = Conversation.between(sender,
     		recipient).first
 		else
  			@conversation = Conversation.new(conversation_params)
  			@conversation.save
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
  		params.require(:conversation).permit(:sender_id, :recipient_id, :recipient_class, :sender_class)
 	end

end