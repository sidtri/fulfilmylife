class WelcomeController < ApplicationController
  def index
  	if current_user
      @programs = current_user.programs

      card_ids = @programs.collect do |program|
      	events = program.event
      	calendar_events = events.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date) }

        # program.cards.where.not(id: current_user.stats.pluck(:card_id))

	  	program.card_templates.where("event_id IN (?)", calendar_events.collect(&:id)).collect(&:card_id)
      end.flatten.uniq

      @cards = Card.where("id IN (?)", card_ids).where.not(id: current_user.stats.pluck(:card_id))
      # @cards = [cards.select{ |a| a.tag == "pushup" }.sample, cards.select{|a| a.tag == "habit"}.sample].compact
    end
  end
end
