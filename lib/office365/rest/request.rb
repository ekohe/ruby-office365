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
        req_url = URI(uri.start_with?("https") ? uri : (Office365::API_HOST + uri))

        response = Faraday.new(url: [req_url.scheme, "://", req_url.hostname].join, headers: headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new($stdout), bodies: true if dev_developement?
        end.get(req_url.request_uri, *args)

        parse_respond(response)
      end

      def post(uri, args)
        req_url = URI(uri.start_with?("https") ? uri : (Office365::API_HOST + uri))

        response = Faraday.new(url: [req_url.scheme, "://", req_url.hostname].join, headers: post_headers) do |faraday|
          faraday.adapter Faraday.default_adapter
          faraday.response :json
          faraday.response :logger, ::Logger.new($stdout), bodies: true if dev_developement?
        end.post(req_url.request_uri, args.to_query)

        parse_respond(response)
      end

      private

      def parse_respond(response)
        resp_body = response.body

        return resp_body if response.status == 200
        raise InvalidAuthenticationTokenError, resp_body.dig("error", "message") if response.status == 401
        raise InvaliRequestError, resp_body["error_description"] if response.status == 400

        raise Error, resp_body["error"]
      end

      def headers
        {
          "Content-Type" => "application/json",
          "Authorization" => "Bearer #{access_token}"
        }
      end

      def dev_developement?
        debug
      end

      def post_headers
        {
          "Content-Type" => "application/x-www-form-urlencoded"
        }
      end
    end
  end
end
