require 'google/apis/calendar_v3'
# Google Calendar service
service = Google::Apis::CalendarV3::CalendarService.new
service.authorization = Google::Auth.get_application_default(["https://www.googleapis.com/auth/calendar"])

Rails.configuration.gcal_service = service