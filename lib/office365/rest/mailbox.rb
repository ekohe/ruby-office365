# frozen_string_literal: true

module Office365
  module REST
    module Mailbox
      def messages
        messages_uri = ["/", Office365::API_VERSION, "/me/messages"].join
        response = Request.new(access_token, debug: debug).get(messages_uri)

        response["value"].map { |v| Models::Mailbox.new(v) }
      end
    end
  end
end
