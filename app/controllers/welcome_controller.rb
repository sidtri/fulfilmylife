class WelcomeController < ApplicationController
  def index
  	if current_user
      @programs = current_user.programs

      cards = @programs.collect do |program|
        program.cards.where.not(id: current_user.stats.pluck(:card_id))
      end.flatten

      @cards = [cards.select{ |a| a.tag == "pushup" }.sample, cards.select{|a| a.tag == "habit"}.sample].compact
    end
  end
end
