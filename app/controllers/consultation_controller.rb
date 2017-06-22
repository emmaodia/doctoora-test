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
		@room_name = generate_room_name
	end

	def edit
		@consultation = Consultation.find(params[:id])
	end

	def update
		@consultation = Consultation.find(params[:id])
    	@consultation.update(consultation_params)

    	redirect_to consultation_index_path
	end

	def destroy
		@consultation = consultation.find(params[:id])
    	@consultation.destroy
    	flash[:notice] = "Your consultation has been deleted successfully"
    	redirect_to consultation_index_path
	end

	private

	def consultation_params
		params.require(:consultation).permit(:discipline, :service, :tool, :date, :start_time, :end_time, :professional)
	end

	def generate_room_name
		#using the Haikunator gem
		Haikunator.haikunate
	end

end