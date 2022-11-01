# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Event
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def events(args = {})
        response = message_response(args: args.merge(base_uri: "/me/events"))

        {
          results: response["value"].map { |v| Models::Event.new(v) },
          next_link: response["@odata.nextLink"]
        }
      end
    end
  end
end
