module GoogleConsole
   class BaseController < ApplicationController

   	 def callback
   	 	client = Signet::OAuth2::Client.new(calendar_options)
   	 	client.code = params[:code]
   	 	response = client.fetch_access_token!
   	 	session[:authorization] = response
   	 	redirect_to calendar_events_path
   	 end

  	 def authenticate_calendar
  	 	unless current_client
			client = Signet::OAuth2::Client.new(calendar_options)
			redirect_to client.authorization_uri.to_s
		end
	 end

   	 def current_client
   	 	return @client if @client.present?
   	 	if session[:authorization]
			@client = Signet::OAuth2::Client.new(calendar_options)
 			@client.update!(session[:authorization])
   	 	end
   	 end

     private
     	def calendar_options
	     	{
	     	  client_id: ENV["google_oauth_client_id"],
	     	  client_secret: ENV["google_oauth_client_secret"],
	     	  authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
	     	  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
	     	  scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
	     	  redirect_uri: google_console_callback_url
	     	}
     	end
   end
end