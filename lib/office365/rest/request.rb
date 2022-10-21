# frozen_string_literal: true

require "faraday"
require "faraday_middleware"
require "logger"
require "json"

module Office365
  module REST
    class Request
      attr_accessor :access_token, :debug

      def initialize(access_token, debug: false)
        @access_token = access_token
        @debug = debug
      end

      def get(uri, args: {})
        response = Faraday.new(url: Office365::API_HOST, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new($stdout), bodies: true if dev_developement?
        end.get(uri, *args)

        resp_body = response.body
        return resp_body if response.status == 200
        raise InvalidAuthenticationTokenError, resp_body.dig("error", "message") if response.status == 401

        raise Error, resp_body["error"]
      end

      def post(uri, args)
        response = Faraday.new(url: Office365::API_HOST, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new($stdout), bodies: true if dev_developement?
        end.post(uri, args)

        resp_body = response.body
        return resp_body if response.status == 200
        raise InvalidAuthenticationTokenError, resp_body.dig("error", "message") if response.status == 401

        raise Error, resp_body["error"]
      end

      private

      def headers
        {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{access_token}"
        }
      end

      def dev_developement?
        debug
      end
    end
  end
end
