class AdminController < ApplicationController

	before_action :authenticate_admin!

	def index
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

	def manage_plans
	end

end