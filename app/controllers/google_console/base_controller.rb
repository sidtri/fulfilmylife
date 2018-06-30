module GoogleConsole
   class BaseController < ApplicationController

   	 def callback
      # auth_client = GoogleCalendarPublishEvents.new.auth_client
      # auth_client.code = params[:code]

      # auth_client.update!(:redirect_uri => google_console_callback_url)
      # token = auth_client.fetch_access_token!

      # current_user.gc_session_id = token
      # current_user.save

      # session[:gc_session_id] = token

   	 	
      # client = Signet::OAuth2::Client.new(calendar_options)
   	 	# client.code = params[:code]
   	 	# response = client.fetch_access_token!

      # u = current_user
      # u.gc_session_id = response
      # u.save

   	 	# session[:authorization] = response
   	 	redirect_to calendar_events_path
   	 end

     # def authenticate_calendar
     #  if current_client

     #  else
     #    redirect_to GoogleCalendarPublishEvents.new.authenticate_url
     #  end
     # end

     # def current_client
     #  return nil if session[:gc_session_id].blank?

     #  GoogleCalendarPublishEvents.new.auth_client
     # end

     private

     def authorize(service)
      service.authorization = Google::Auth.get_application_default(["https://www.googleapis.com/auth/calendar"])
     end

  	 # def authenticate_calendar
  	 # 	unless current_client
			 # client = Signet::OAuth2::Client.new(calendar_options)
			 # redirect_to client.authorization_uri.to_s
		  # end
	   # end

    #  def authorize(service)
    #   # begin
    #     service.authorization = current_client
    #   # rescue Google::Apis::AuthorizationError
    #   #   refresh_token
    #   #   service.authorization = current_client
    #   # end
    #  end

    #  def refresh_token
    #   response = current_client.refresh_token
    #   session[:authorization] = session[:authorization].merge(response)
    #   new_client
    #  end

   	#  def current_client
    #   binding.pry
   	#  	return @client if @client.present?
   	#  	if session[:authorization]
    #     new_client
   	#  	end
   	#  end

    #  def new_client(token=session[:authorization])
    #    @client = Signet::OAuth2::Client.new(calendar_options)
    #    response = @client.update!(token)
    #    session[:authorization] = response
    #    @client
    #  end

     # private
     # 	def calendar_options
	    #  	{
	    #  	  client_id: ENV["google_oauth_client_id"],
	    #  	  client_secret: ENV["google_oauth_client_secret"],
	    #  	  authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
	    #  	  token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
	    #  	  scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
	    #  	  redirect_uri: google_console_callback_url
	    #  	}
     # 	end
   end
end