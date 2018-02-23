class CardsController < ApplicationController
  def show
  	@card = Card.friendly.find(params[:id])
  end
end
