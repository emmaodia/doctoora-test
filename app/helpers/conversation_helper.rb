module ConversationHelper

	def get_sender conversation
		if doctor_signed_in?
			patient = User.find(conversation.recipient_id)
			return patient.first_name + " " + patient.last_name
		elsif user_signed_in?
			doc = Doctor.find(conversation.sender_id)
			return "Dr " + doc.first_name + " " + doc.last_name
		end	
	end

end