class UpdateDailyEvent
 include Sidekiq::Worker
 include Rails.application.routes.url_helpers

  def perform(user)
  	today = DateTime.now
  	@user = user
  	client = Signet::OAuth2::Client.new(client_options)
  	client.update!(session_options)

  	service = Google::Apis::CalendarV3::CalendarService.new
  	service.authorization = client

  	@cards = FetchCardsForUser.new(@user, DateTime.now).call

  	events = []
  	@cards.each do |card|
  	    event = Google::Apis::CalendarV3::Event.new({
  	      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour),
  	      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: today + 1.hour + 5.minutes),
  	      summary: "#{card.title}",
  	      color_id: rand(1..10).to_s,
  	      html_link: card_url(card.slug),
  	      status: "tentative",
  	      reminders: {
  	        useDefault: true
  	      },
  	      description: "Mark as complete: #{card_url(card.slug)}. \n #{card.sub_title}"
  	    })

  	    events << event
  	end

	events.each do |event|
	  	service.insert_event(service.list_calendar_lists.items.first.id, event)
	end

  	rescue Google::Apis::AuthorizationError
  		  refresh_token(client)

  	      retry
  end

  private

  	def refresh_token(client)
	  client.refresh_token = @user.access_token
	  response = client.refresh!

	  @user.refresh_token = response["access_token"]
	  @user.expires_in = DateTime.now + response["expires_in"].seconds
	  @user.save
  	end

  	def client_options
  		{
  		  client_id: ENV["google_client_id"],
  		  client_secret: ENV["google_client_secret"],
  		  authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
  		  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
  		  scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
  		  redirect_uri: callback_url
  		}
  	end

  	def session_options
  		{"access_token"=>@user.access_token,
  		 "expires_in"=>1600,
  		 "scope"=>"https://www.googleapis.com/auth/calendar",
  		 "token_type"=>"Bearer"}  		
  	end
end