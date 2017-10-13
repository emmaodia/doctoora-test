class AdminController < ApplicationController

	before_action :authenticate_admin!, except: [:render_activation_form, :activate]

	def index
	end

	def render_activation_form
		render 'activate'
	end

	def activate
		if params[:password] == ENV['ACTIVATION_PASSWORD']
			redirect_to new_admin_registration_path
		else
			flash[:notice] = "Incorrect Password"
		end
	end

	def verify_doctors
		@doctors = Doctor.where("verified = false")
	end

	def verify_doctor
		@doctor = Doctor.find(params[:id])
	end

	def verify
		doctor = Doctor.find(params[:id])
		doctor.verified = true
		doctor.save
		flash["notice"] = "Doctor has now been verified"
		redirect_to admin_path
	end

	def plans
		@plans = Plan.all
	end

	def new_plan
		@plan = Plan.new
	end

	def create_plan
		plan = Plan.new(plan_params)
		if plan.save
			flash["notice"] = "Plan successfully created"
			redirect_to admin_plans_path
		else
			flash["notice"] = "Plan could not be saved"
			render 'new'
		end
	end

	def view_patients
		@patients = User.all
	end

	def view_doctors
		@doctors = Doctor.all
	end

	private

	def plan_params
		params.require(:plan).permit(:title, :description, :price, :category)
	end

end