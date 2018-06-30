class CalendarEventWorker
  include Sidekiq::Worker

  def perform
   params = {}
   today = DateTime.now.beginning_of_day

    # events
    @programs = Program.where(active: true)

    card_ids = @programs.collect do |program|
    	events = program.event
    	calendar_events = events.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date) }
	  	program.card_templates.where("event_id IN (?)", calendar_events.collect(&:id)).collect(&:card_id)
    end.flatten.uniq

    @cards = Card.includes(:category).where("id IN (?)", card_ids)

    events = []
    @cards.each do |card|
        card_id = card_id.to_s
        event = Google::Apis::CalendarV3::Event.new({
          start: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 7.hour),
          end: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 7.hour + 5.minutes),
          summary: "#{card.title}",
          color_id: rand(1..10).to_s,
          reminders: {
            useDefault: true
          },
          source: ENV["default_url_options_host"],
          visibility: "public",
          html_link: Rails.application.routes.url_helpers.card_url(card.slug),
          description: "Mark as complete: #{Rails.application.routes.url_helpers.card_url(card.slug)}. \n #{card.sub_title}"
        })

        events << event
    end
    c = AddEventsToGcal.new
    c.call(events)
  end
end
