# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Event
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def events(args = {})
        wrap_results(args.merge(kclass: Models::Event, base_uri: "/me/events"))
      end
    end
  end
end
