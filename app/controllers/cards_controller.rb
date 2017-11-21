class CardsController < ApplicationController

	before_action :authenticate_admin!

	def index
		@cards = Card.all
	end

	def new
		@card = Card.new
	end
	
	def create
		@card = Card.new(card_params)

		if @card.save
			flash[:notice] = "Card created"
			redirect_to cards_path
		else
			flash[:notice] = "Problem creating card"
			render 'new'
		end
	end

	def edit
		@card = Card.find(params[:id])
	end

	def update
		@card = Card.find(params[:id])
		@card.update(card_params)

		redirect_to cards_path
	end

	def destroy
		@card = Card.find(params[:id])
		@card.destroy
		flash[:notice] = "Card deleted successfully"
		redirect_to cards_path
	end

	private

	def card_params
		params.require(:card).permit(:link, :title, :body, :image, :page)
	end

end