module PatientReviewsHelper

	def get_user_address house, town
		return house + " " + town
	end
end