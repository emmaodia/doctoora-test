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

	def notifications
		@notifications = AdminNotification.all
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
		flash["notice"] = "Professional has now been verified"
		redirect_to verify_doctors_path
	end

	def plans
		@plans = Plan.all
	end

	def new_plan
		@plan = Plan.new
		@categories = ProductCategory.all.map(&:name)
	end

	def create_plan
		category = ProductCategory.find_by_name(params[:plan][:product_category])
		plan = category.plans.new(plan_params)
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
		@doctors = Doctor.where('verified = ?', true)
	end

	def insurance
		@transactions = Transaction.where('purpose = ? AND status = ?', 'insurance', 'processing')
	end

	def complete_insurance_payment
		transaction = Transaction.find params[:id]
		transaction.status = :complete
		transaction.save
		redirect_to admin_insurance_path
	end

	def clinic_rentals
		@clinic_rentals = ClinicRental.all.order(date: :asc)
	end

	def product_categories
		@categories = ProductCategory.all
	end

	def new_product_category
		@category = ProductCategory.new
	end

	def add_product_category
		@category = ProductCategory.new(product_category_params)
		if @category.save
			flash["notice"] = "Category created"
			redirect_to admin_product_categories_path
		else
			flash["notice"] = "Category could not be created"
			redirect_to :back
		end
	end

	def category_products
		@products = ProductCategory.find_by_name(params[:category_name]).plans
	end

	private

	def plan_params
		params.require(:plan).permit(:title, :description, :price, :category, :image)
	end

	def product_category_params
		params.require(:product_category).permit(:name)
	end
end