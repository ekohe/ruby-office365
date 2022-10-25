# frozen_string_literal: true

module Office365
  module REST
    module Contact
      def contact
        calendars_uri = ["/", Office365::API_VERSION, "/me/contacts"].join
        response = Request.new(access_token, debug: debug).get(calendars_uri)

        response["value"].map { |v| Models::User.new(v) }
      end
    end
  end
end
