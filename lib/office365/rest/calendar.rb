# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Calendar
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def calendars(args = {})
        wrap_results(args.merge(kclass: Models::Calendar, base_uri: "/me/calendars"))
      end
    end
  end
end
