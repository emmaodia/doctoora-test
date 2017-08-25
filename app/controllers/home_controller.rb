class HomeController < ApplicationController

	def index
		if user_signed_in?
			@notifications = current_user.notifications.last(5).reverse
		end
	end
	
	def knowledgebase
	end
	
end
