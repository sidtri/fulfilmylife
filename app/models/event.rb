class Event < ApplicationRecord
	serialize :recurring, Hash

	belongs_to :card

	def recurring=(value)
		if RecurringSelect.is_valid_rule?(value)
			r = RecurringSelect.dirty_hash_to_rule(value)
			if r.nil?
				super({})
			else
				super(r.to_hash)
			end
		else
			super(nil)
		end
	end

	def rule
		IceCube::Rule.from_hash recurring
	end

	def schedule(start)
		schedule = IceCube::Schedule.new(start)
		schedule.add_recurrence_rule(rule)

		schedule
	end

	def calendar_events(start)
		if recurring.empty?
			[self]
		else
			start_date = start.beginning_of_month.beginning_of_week
			end_date = start.end_of_month.end_of_week
			schedule(start_time).occurrences(end_date).map do |date|
		    	Event.new(id: id, name: name, start_time: date)
		    end
		end
	end
end
