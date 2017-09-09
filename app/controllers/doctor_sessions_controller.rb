class DoctorSessionsController < Devise::SessionsController
	def after_sign_in_path_for(resource_or_scope)
 		if resource.verified == true && resource.town == nil
 			new_doctor_onboarding_path
 		else
 			root_path
 		end
	end
end