class HomeController < ApplicationController

	def index
		if user_signed_in?
			@notifications = current_user.notifications.last(5).reverse
		end
	end
	
	def knowledgebase
	end

	def new_search
	end

	def search_results
		@doctors = Doctor.search(params[:location], params[:specialization]).order('created_at DESC')
	end
	
end
