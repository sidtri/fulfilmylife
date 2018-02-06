class StatsController < ApplicationController
  def create
  	stat = current_user.stats.build
  	stat.card_id = params[:card_id]

  	if stat.save
  		redirect_to root_path
  	else
  		redirect_to :back
  	end
  end
end
