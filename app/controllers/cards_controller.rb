class CardsController < ApplicationController
  def show
  	@card = Card.friendly.find(params[:id])
  	@survey = NewSurvey.new
  end
end
