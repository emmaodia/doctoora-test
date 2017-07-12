module ProfileHelper

	def my_profile?
		if !current_user
			return false
		end
		return current_user.id == params[:id]
	end
end