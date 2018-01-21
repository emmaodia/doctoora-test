module ConversationHelper

	def get_sender_or_recipient conversation
		if conversation.sender_class == "Patient"
			if doctor_signed_in?
				patient = User.find(conversation.sender_id)
				return patient.first_name + " " + patient.last_name
			else
				doc = Doctor.find(conversation.recipient_id)
				return doc.title + " " + doc.first_name + " " + doc.last_name
			end
		elsif conversation.sender_class == "Doctor"
			if user_signed_in?
				doc = Doctor.find(conversation.sender_id)
				return doc.title + " " + doc.first_name + " " + doc.last_name
			else
				patient = User.find(conversation.recipient_id)
				return patient.first_name + " " + patient.last_name
			end
		end	
	end

	def get_sender_first_name message
		if message.user_class == "Doctor"
			doc = Doctor.find(message.user_id)
			return doc.title + " " + doc.first_name
		elsif message.user_class == "Patient"
			return User.find(message.user_id).first_name
		end
	end

end