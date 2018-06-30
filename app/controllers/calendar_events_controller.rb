# https://readysteadycode.com/howto-integrate-google-calendar-with-rails
require 'google/apis/calendar_v3'

class CalendarEventsController < GoogleConsole::BaseController

  before_filter :get_service

    def remove
    end

    def share
        @service.insert_acl('primary',
            Google::Apis::CalendarV3::AclRule.new(role: 'reader', 
                scope: Google::Apis::CalendarV3::AclRule::Scope.new(value: current_user.email, 
                    type: 'user', id: "user:#{current_user.email}", kind: "calendar#aclRule")
                )
            )
        render text: "success"
    end

	def index
     today = DateTime.now

      # events
      @programs = current_user.programs

      card_ids = @programs.collect do |program|
      	events = program.event
      	calendar_events = events.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date) }
        # program.cards.where.not(id: current_user.stats.pluck(:card_id))
  	  	program.card_templates.where("event_id IN (?)", calendar_events.collect(&:id)).collect(&:card_id)
      end.flatten.uniq

      @cards = Card.includes(:category).where("id IN (?)", card_ids).where.not(id: current_user.stats.pluck(:card_id))

      events = []
      @cards.each do |card|
          card_id = card_id.to_s
          event = Google::Apis::CalendarV3::Event.new({
            start: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour),
            end: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour + 5.minutes),
            summary: "#{card.title}",
            color_id: rand(1..10).to_s,
            reminders: {
              useDefault: true
            },
            description: "Mark as complete: #{card_url(card.slug)}. \n #{card.sub_title}"
          })

          events << event
      end

      calendar = AddEventsToGcal.new
      calendar.call(events)

      flash[:notice] = "Events added to your calendar list"
      redirect_to root_path
	end

    private
        def get_service
            @service = Google::Apis::CalendarV3::CalendarService.new
            authorize(@service)
        end

end
