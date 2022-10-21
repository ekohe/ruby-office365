# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "logger"
require "json"

require_relative "./api"

module Office365
  module REST
    class Client < Office365::Client
      include Office365::REST::API
      attr_accessor :bearer_token

      # @return [Boolean]
      def bearer_token?
        !!bearer_token
      end

      # @return [Boolean]
      def credentials?
        super || bearer_token?
      end
    end
  end
end
