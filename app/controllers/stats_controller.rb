class StatsController < ApplicationController
  def create

  	if create_stat(current_user, params[:card_id])
  		redirect_to root_path
  	else
  		redirect_to :back
  	end
  end
end
