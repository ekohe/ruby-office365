# frozen_string_literal: true

module Office365
  module REST
    module Token
      def authorize_url
        base_uri = [LOGIN_HOST, "/#{tenant_id}/oauth2/v2.0/authorize"].join
        azure_params = {
          client_id: client_id,
          client_secret: client_secret,
          scope: Office365::SCOPE,
          response_type: "code",
          response_mode: "query",
          redirect_uri: redirect_uri,
          state: SecureRandom.hex
        }.to_query

        [base_uri, "?", azure_params].join
      end

      def token_url
        [LOGIN_HOST, "/#{tenant_id}/oauth2/v2.0/token"].join
      end

      def refresh_token!
        post(token_url, {
               refresh_token: refresh_token,
               client_id: client_id,
               client_secret: client_secret,
               grant_type: "refresh_token",
               scope: Office365::SCOPE
             })
      end
    end
  end
end
