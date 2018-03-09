# https://readysteadycode.com/howto-integrate-google-calendar-with-rails
require 'google/apis/calendar_v3'

class CalendarEventsController < GoogleConsole::BaseController

  before_filter :authenticate_calendar

	def index
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_client

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
    # end

    @cards.each do |card|
      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour),
        end: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour + 5.minutes),
        summary: card.title,
        colorId: card.category.try(:color),
        reminders: {
          useDefault: true
        },
        description: card.sub_title
      })
      begin
        service.insert_event('primary', event)
  	  rescue Google::Apis::AuthorizationError
        binding.pry
      end
    end

    flash[:notice] = "Events added to your calendar list"
    redirect_to root_path
	end

end
