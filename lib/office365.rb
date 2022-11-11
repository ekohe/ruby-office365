# frozen_string_literal: true

require_relative "office365/version"

require "office365/utils"
require "office365/client"
require "office365/rest"
require "office365/models"

module Office365
  class Error < StandardError; end
  class InvalidAuthenticationTokenError < StandardError; end
  class InvaliRequestError < StandardError; end

  # Handling expected errors -> https://learn.microsoft.com/en-us/graph/best-practices-concept#handling-expected-errors
  class AccessDeniedError < StandardError; end
  class NotFoundError < StandardError; end
  class ThrottlingError < StandardError; end
  class ServiceUnavailableError < StandardError; end

  API_HOST      = "https://graph.microsoft.com"
  API_VERSION   = "v1.0"

  LOGIN_HOST    = "https://login.microsoftonline.com"
  SCOPE         = "offline_access User.read Calendars.read Mail.ReadBasic Contacts.Read"
  # Your code goes here...
end
