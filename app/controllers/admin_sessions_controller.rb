class AdminSessionsController < Devise::SessionsController
	def after_sign_in_path_for(resource_or_scope)
 		admin_path
	end
end