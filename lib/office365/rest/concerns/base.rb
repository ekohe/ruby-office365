# frozen_string_literal: true

module Office365
  module REST
    module Concerns
      module Base
        private

        def message_response(args: {})
          next_link = args.delete(:next_link)

          request_uri = if next_link
                          next_link
                        else
                          base_uri = args.delete(:base_uri)

                          req_uri = ["/", Office365::API_VERSION, base_uri].join
                          req_uri += ["?", args.to_query].join if args.any?
                          req_uri
                        end

          Request.new(access_token, debug: debug).get(request_uri)
        end
      end
    end
  end
end
