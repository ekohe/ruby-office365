# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Contact
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def contacts(args = {})
        wrap_results(args.merge(kclass: Models::Contact, base_uri: "/me/contacts"))
      end
    end
  end
end
