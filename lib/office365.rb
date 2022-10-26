# frozen_string_literal: true

require_relative "office365/version"

require "office365/utils"
require "office365/client"
require "office365/rest"
require "office365/models"

module Office365
  API_HOST      = "https://graph.microsoft.com"
  API_VERSION   = "v1.0"

  LOGIN_HOST    = "https://login.microsoftonline.com"
  SCOPE         = "User.read Calendars.read Mail.ReadBasic Contacts.Read"

  class Error < StandardError; end
  class InvalidAuthenticationTokenError < StandardError; end
  # Your code goes here...
end
