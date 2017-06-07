class ConsultationController < ApplicationController

	def index
		@consultations = current_user.consultations.all.order(date: :desc)
	end

	def new
		@consultation = current_user.consultations.new
	end

	def create
		@consultation = current_user.consultations.new(consultation_params)

		if @consultation.save
			flash[:notice] = "Your consultation has been booked and will be verified"
			redirect_to root_path
		else
			flash[:notice] = "There was an error creating your consultation"
			render 'new'
		end
	end

	def show
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private

	def consultation_params
		params.require(:consultation).permit(:discipline, :service, :tool, :date, :start_time, :end_time, :professional)
	end

end