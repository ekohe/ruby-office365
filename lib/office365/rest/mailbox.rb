# frozen_string_literal: true

require_relative "./concerns/base"

module Office365
  module REST
    module Mailbox
      include Concerns::Base

      # params: args => { next_link: (nil / next_page_url) }
      # response { results: [], next_link: '...' }
      def messages(args = {})
        wrap_results(args.merge(kclass: Models::Mailbox, base_uri: "/me/messages"))
      end
    end
  end
end
