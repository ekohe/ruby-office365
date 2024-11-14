# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Event
      include Concerns::Base
      BASE_URI = "/me/events"
      CALENDARVIEW_URL = "/me/calendarview"

      # params: args => { next_link: (nil / next_page_url) }
      #   startdatetime: 2024-11-14T07:59:41.313Z
      #   enddatetime: 2024-11-21T07:59:41.313Z
      # response { results: [], next_link: '...' }
      def events(args = {})
        if args[:startdatetime] && args[:enddatetime]
          wrap_results(
            kclass: Models::Event,
            base_uri: CALENDARVIEW_URL,
            startdatetime: args[:startdatetime],
            enddatetime: args[:enddatetime]
          )
        else
          wrap_results(args.merge(kclass: Models::Event, base_uri: BASE_URI))
        end
      end

      def event(identifier)
        raise ArgumentError, "Identifier must be provided" if identifier.nil? || identifier.empty?

        wrap_results(kclass: Models::Event, base_uri: [BASE_URI, identifier].join("/"), identifier: identifier)
      end
    end
  end
end
