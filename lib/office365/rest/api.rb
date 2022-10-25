# frozen_string_literal: true

require_relative "./user"
require_relative "./mailbox"
require_relative "./calendar"
require_relative "./contract"
require_relative "./token"

module Office365
  module REST
    module API
      include Office365::REST::User
      include Office365::REST::Mailbox
      include Office365::REST::Calendar
      include Office365::REST::Contract
      include Office365::REST::Token
    end
  end
end
