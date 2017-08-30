class DoctorsController < ApplicationController

	def index
		@doctor = current_doctor
	end
	
end