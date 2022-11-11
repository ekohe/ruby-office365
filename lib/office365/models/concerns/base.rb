# frozen_string_literal: true

require "ostruct"

module Office365
  module Models
    class Base < OpenStruct
      def initialize(response = {})
        super(response.transform_keys(&:rails_underscore))
      end

      def as_json
        to_h
      end
    end
  end
end
