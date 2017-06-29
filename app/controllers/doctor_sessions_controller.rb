class DoctorSessionsController < Devise::SessionsController
	def after_sign_in_path_for(resource_or_scope)
 		doctors_path
	end
end