class ClinicsController < ApplicationController

	before_action :authenticate_admin!, except: [:index]

	def index
		@clinics = Clinic.all
	end

	def new
		@clinic = Clinic.new
	end

	def create
		@clinic = Clinic.new(clinic_params)

		if @clinic.save
			flash[:notice]= "Clinic created successfully"
			redirect_to clinics_path
		else
			flash[:notice]= "Problem creating clinic"
			render 'new'
		end
	end

	# def show
	# 	@clinic = Clinic.find(params[:id])
	# end

	def edit
		@clinic = Clinic.find(params[:id])
	end

	def update
		@clinic = Clinic.find(params[:id])
    	@clinic.update(clinic_params)

    	redirect_to clinics_path
	end

	def destroy
		@clinic = clinic.find(params[:id])
    	@clinic.destroy
    	flash[:notice] = "#{@clinic.title} deleted successfully"
    	redirect_to clinics_path
	end

	private

	def clinic_params
		params.require(:clinic).permit(:name, :address, :phone, :town, :image)
	end

end