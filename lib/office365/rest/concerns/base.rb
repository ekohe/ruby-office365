# frozen_string_literal: true

module Office365
  module REST
    module Concerns
      module Base
        private

        def wrap_results(args)
          kclass    = args.delete(:kclass)
          get_by_id = args.delete(:get_by_id)

          response  = get_request(args: args)

          # If we are getting a single item by id, return the result as an array
          return { results: [response].flatten } if get_by_id

          {
            results: response["value"].map { |v| kclass.new(v) },
            next_link: response["@odata.nextLink"]
          }
        end

        def get_request(args: {})
          request_uri = parse_and_build_request_url(args)

          Request.new(access_token, debug: debug).get(request_uri)
        end

        # https://learn.microsoft.com/en-us/graph/query-parameters?view=graph-rest-1.0
        # OData system query options
        # Click the examples to try them in [Graph Explorer](https://developer.microsoft.com/zh-cn/graph/graph-explorer)

        # $count  Retrieves the total count of matching resources.  /me/messages?$top=2&$count=true
        # $expand Retrieves related resources.  /groups?$expand=members
        # $filter Filters results (rows). /users?$filter=startswith(givenName,'J')
        # $format Returns the results in the specified media format.  /users?$format=json
        # $orderby  Orders results. /users?$orderby=displayName desc
        # $search Returns results based on search criteria. /me/messages?$search=pizza
        # $select Filters properties (columns). /users?$select=givenName,surname
        # $skip Indexes into a result set.
        #   Also used by some APIs to implement paging and can be used together with $top to manually page results.  /me/messages?$skip=11
        # $top  Sets the page size of results.  /users?$top=2
        def parse_and_build_request_url(args)
          next_link = args.delete(:next_link)
          return next_link unless next_link.nil?

          # organize params
          base_uri        = args.delete(:base_uri)
          select_fields   = args.delete(:select)
          order_by        = args.delete(:order)
          args[:select]   = select_fields.map(&:rails_camelize).join(",") if select_fields.is_a?(Array)
          args[:orderby]  = order_by if order_by

          request_uri = ["/", Office365::API_VERSION, base_uri].join
          request_uri += ["?", args.ms_hash_to_query].join if args.any?
          request_uri
        end
      end
    end
  end
end
