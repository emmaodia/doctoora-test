class HomeController < ApplicationController

	def index
		@notifications = current_user.notifications.last(5).reverse
	end
	
	def knowledgebase
	end

	def new_search
	end

	def search_results
		@doctors = Doctor.search(params[:location], params[:specialization]).order('created_at DESC')
	end
	
end
