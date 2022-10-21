# frozen_string_literal: true

module Office365
  module REST
    module Mailbox
      def messages
        message_response["value"].map { |v| Models::Mailbox.new(v) }
      end

      # response = client.messages_with_nextlink
      # response[:results].each -> data save
      # if response[:next_link].present? client.messages_with_nextlink(response[:next_link])
      def messages_with_nextlink(next_link = nil)
        response = message_response(next_link)

        {
          results: response["value"].map { |v| Models::Mailbox.new(v) },
          next_link: response["@odata.nextLink"]
        }
      end

      private

      def message_response(next_link = nil)
        messages_uri = next_link || ["/", Office365::API_VERSION, "/me/messages"].join
        Request.new(access_token, debug: debug).get(messages_uri)
      end
    end
  end
end
