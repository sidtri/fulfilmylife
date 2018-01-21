class ProgressesController < ApplicationController
  def create
  	progress = current_user.progresses.build
  	progress.card_id = params[:card_id]

  	if progress.save
  		redirect_to root_path
  	else
  		redirect_to :back
  	end
  end
end
