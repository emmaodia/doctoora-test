class OnboardingController < ApplicationController

	def new
		@user = User.find(current_user.id)
	end

	def create
		user = User.find(current_user.id)
		parameters = params["user"]

		#save dob as an array and remove it from the params to be iterated over
		user.dob = Date.civil(parameters["dob(1i)"].to_i,parameters["dob(2i)"].to_i,parameters["dob(3i)"].to_i)
		user.bmi = ((parameters["weight"].to_i/parameters["height"].to_f)/parameters["height"].to_f)

		(0..2).each do
			parameters.shift
		end

		assign_values parameters, user
		
		if user.save
			redirect_to onboarding_new_additional_info_path
		else
			flash[:notice] = "There was an error saving your information"
			render 'new'
		end
	end

	def additional_info
		@user = User.find(current_user.id)
	end

	def submit_additional_info
		user = User.find(current_user.id)
		assign_values params["user"], user

		if user.save
			redirect_to root_path
		else
			flash[:notice] = "There was an error saving your information"
			render 'additional_info'
		end
	end

	private

	def assign_values params, user
		params.each do |param|
			key = param[0]
			user[key] = param[1]
		end
	end
	
end