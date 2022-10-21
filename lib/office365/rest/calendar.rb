# frozen_string_literal: true

module Office365
  module REST
    module Calendar
      def calendars
        calendars_uri = ["/", Office365::API_VERSION, "/me/calendars"].join
        response = Request.new(access_token, debug: debug).get(calendars_uri)

        response["value"].map { |v| Models::Calendar.new(v) }
      end
    end
  end
end
