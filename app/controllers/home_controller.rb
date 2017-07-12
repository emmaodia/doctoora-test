class HomeController < ApplicationController

	def index
	end
	
	def knowledgebase
	end

	def new_search
	end

	def search_results
		@doctors = Doctor.search(params[:location], params[:specialization]).order('created_at DESC')
	end
	
end
