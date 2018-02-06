class WelcomeController < ApplicationController
  def index
  	if current_user
      @cards = current_user.programs
    end
  end
end
