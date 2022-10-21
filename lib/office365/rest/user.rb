# frozen_string_literal: true

require_relative "request"

module Office365
  module REST
    module User
      def me
        profile_uri = ["/", Office365::API_VERSION, "/me"].join
        Models::User.new(Request.new(access_token, debug: debug).get(profile_uri))
      end
    end
  end
end
