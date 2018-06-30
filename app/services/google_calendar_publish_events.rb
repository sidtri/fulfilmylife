require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

require 'google/apis/calendar_v3'


class GoogleCalendarPublishEvents
	def initialize(user=nil)
		@user = user
	end

	# [TODO] make wrapper
	def events
	    @programs = @user.programs

	    card_ids = @programs.collect do |program|
	    	events = program.event
	    	calendar_events = events.flat_map{ |e| e.calendar_events(params.fetch(:start_date, Time.zone.now).to_date) }
		  	program.card_templates.where("event_id IN (?)", calendar_events.collect(&:id)).collect(&:card_id)
	    end.flatten.uniq

	    @cards = Card.includes(:category).where("id IN (?)", card_ids).where.not(id: @user.stats.pluck(:card_id))
	end


	def authenticate_url
		auth_client.update!(
		  :scope => 'https://www.googleapis.com/auth/calendar',
		  :redirect_uri => Rails.application.routes.url_helpers.google_console_callback_url,
		  :additional_parameters => {
		    "access_type" => "offline",         # offline access
		    "include_granted_scopes" => "true"  # incremental auth
		  }
		)
		binding.pry
		auth_client.authorization_uri.to_s
	end

	def auth_client
		return @auth_client if @auth_client.present?
		@auth_client ||= client_secrets.to_authorization

		@auth_client
	end

	private
		def client_secrets
			@auth_client ||= Google::APIClient::ClientSecrets.load Rails.root.join("client_secret.json")
		end
end