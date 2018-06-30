OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.development?
    provider :google_oauth2, ENV["google_oauth_client_id"], ENV["google_oauth_client_secret"], { access_type: 'offline', approval_prompt: "consent", scope: 'userinfo.email,calendar' }
  else
  	provider :google_oauth2, ENV["google_oauth_client_id"], ENV["google_oauth_client_secret"], {scope: 'calendar', client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
  end
end

module Signet
  module OAuth2
    class Client
      # def redirect_uri=(new_redirect_uri)
      #   new_redirect_uri = Addressable::URI.send(
      #       new_redirect_uri.kind_of?(Hash) ? :new : :parse,
      #       new_redirect_uri
      #     )
      #   #TODO - Better solution to allow google postmessage flow. For now, make an exception to the spec.
      #   if new_redirect_uri == nil|| new_redirect_uri.absolute? || uri_is_postmessage?(new_redirect_uri) || uri_is_oob?(new_redirect_uri)
      #     @redirect_uri = new_redirect_uri
      #   else
      #     raise ArgumentError, "Redirect URI must be an absolute URI."
      #   end
      # end

      def redirect_uri=(new_redirect_uri)
        new_redirect_uri = build_uri(uri)

        #TODO - Better solution to allow google postmessage flow. For now, make an exception to the spec.
        if new_redirect_uri == nil|| new_redirect_uri.absolute? || uri_is_postmessage?(new_redirect_uri) || uri_is_oob?(new_redirect_uri)
          @redirect_uri = new_redirect_uri
        else
          raise ArgumentError, "Redirect URI must be an absolute URI."
        end
      end

      def build_uri(uri)
        if uri.is_a?(Hash)
          uri_from_hash(uri)
        else
          Addressable::URI.parse(uri)
        end
      end

      def uri_from_hash(hash)
        symbolized = {}
        hash.each_key do |k|
          symbolized[(k.to_sym rescue k)] = hash[k]
        end
        Addressable::URI.new.merge(symbolized)
      end
   end
  end
end