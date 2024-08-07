# frozen_string_literal: true

module Office365
  module REST
    module Subscription
      def create_subscription(args = {})
        Models::Subscription.new(
          Request.new(access_token, debug: debug).post("/v1.0/subscriptions", { json_header: true }.merge(args))
        )
      end

      def renew_subscription(args = {})
        raise ArgumentError, "Missing subscription identifier" if args[:identifier].nil?

        identifier = args.delete(:identifier)

        Models::Subscription.new(
          Request.new(access_token, debug: debug).patch("/v1.0/subscriptions/#{identifier}", { json_header: true }.merge(args))
        )
      end
    end
  end
end