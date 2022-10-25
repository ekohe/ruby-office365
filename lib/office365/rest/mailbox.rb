# frozen_string_literal: true

module Office365
  module REST
    module Mailbox
      def messages(params = {})
        message_response(params: params)["value"].map { |v| Models::Mailbox.new(v) }
      end

      # response = client.messages_with_nextlink
      # response[:results].each -> data save
      # if response[:next_link].present? client.messages_with_nextlink(response[:next_link])
      def messages_with_nextlink(next_link: nil, params: {})
        response = message_response(next_link: next_link, params: params)

        {
          results: response["value"].map { |v| Models::Mailbox.new(v) },
          next_link: response["@odata.nextLink"]
        }
      end

      private

      def message_response(params: {}, next_link: nil)
        messages_uri = ["/", Office365::API_VERSION, "/me/messages"].join
        if params.any?
          messages_uri = [messages_uri, "?", params.to_query].join
        elsif next_link
          messages_uri = next_link
        end

        Request.new(access_token, debug: debug).get(messages_uri)
      end
    end
  end
end
