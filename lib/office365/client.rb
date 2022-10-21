# frozen_string_literal: true

module Office365
  class Client
    attr_accessor :client_id, :client_secret, :access_token, :refresh_token, :redirect_uri, :tenant_id, :debug

    # Initializes a new Client object
    #
    # @param options [Hash]
    # @return [Office365::Client]
    def initialize(options = {})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      yield(self) if block_given?
    end

    # @return [Boolean]
    def user_token?
      !(blank_string?(access_token) || blank_string?(refresh_token))
    end

    # @return [Hash]
    def credentials
      {
        client_id: client_id,
        client_secret: client_secret,
        access_token: access_token,
        refresh_token: refresh_token
      }
    end

    # @return [Boolean]
    def credentials?
      credentials.values.none? { |v| blank_string?(v) }
    end

    private

    def blank_string?(string)
      string.respond_to?(:empty?) ? string.empty? : !string
    end
  end
end
