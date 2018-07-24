class FetchCardsForUser
	def initialize(user, date=DateTime.now)
		@user = user
		@date = date
		@start_date = date.to_date
	end

	def call
	    # events
	    @programs = @user.programs

	    card_ids = @programs.collect do |program|
	    	events = program.event
	    	calendar_events = events.flat_map{ |e| e.calendar_events(@start_date) }
	      # program.cards.where.not(id: @user.stats.pluck(:card_id))
		  	program.card_templates.where("event_id IN (?)", calendar_events.collect(&:id)).collect(&:card_id)
	    end.flatten.uniq

	    @cards = Card.includes(:category).where("id IN (?)", card_ids).where.not(id: @user.stats.pluck(:card_id))
	end
end