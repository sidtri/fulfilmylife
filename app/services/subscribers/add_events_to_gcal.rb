# Add events to google calendar
class AddEventsToGcal
	include Wisper::Publisher

	# events [array] of objects [Google::Apis::CalendarV3::Event]
	def call(events)
        events.each { |event| Rails.configuration.gcal_service.insert_event('primary', event) }
	end

end