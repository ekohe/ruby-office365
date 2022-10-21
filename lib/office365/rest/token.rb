# frozen_string_literal: true

module Office365
  module REST
    module Token
      def token_refresh
        args = {
          refresh_token: refresh_token,
          client_id: client_id,
          client_secret: client_secret,
          grant_type: "refresh_token"
        }

        post(oauth_client.token_url, args)
      end

      private

      def oauth_client
        @oauth_client ||= OAuth2::Client.new(
          client_id,
          client_secret,
          authorize_url: AUTHORIZE_URL,
          site: LOGIN_HOST,
          token_url: TOKEN_URL,
          redirect_uri: redirect_uri
        )
      end
    end
  end
end
