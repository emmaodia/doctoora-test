class AdminRegistrationsController < Devise::RegistrationsController
	def after_sign_up_path_for(resource)
    	admin_path
  	end
end