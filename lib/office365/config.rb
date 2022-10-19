# frozen_string_literal: true

require "singleton"

# Should be config the client and secret first
module Office365
  class Config
    include Singleton

    attr_accessor :client, :secret
  end

  def self.config
    yield Config.instance if block_given?

    Config.instance
  end
end
