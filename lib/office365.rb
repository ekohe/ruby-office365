# frozen_string_literal: true

require_relative "office365/version"

require "office365/config"
require "office365/client"
require "office365/models"

module Office365
  API_DOMAIN    = "https://graph.microsoft.com"
  API_VERSION   = "v1.0"
  BASE_URI      = "#{API_DOMAIN}/#{API_VERSION}/"

  class Error < StandardError; end
  # Your code goes here...
end
