# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Event
      include Concerns::Base
      BASE_URI = "/me/events".freeze

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def events(args = {})
        wrap_results(args.merge(kclass: Models::Event, base_uri: BASE_URI))
      end

      def event(identifier)
        raise ArgumentError, "Identifier must be provided" if identifier.nil? || identifier.empty?

        wrap_results(kclass: Models::Event, base_uri: [BASE_URI, identifier].join("/"), identifier: identifier)
      end
    end
  end
end
