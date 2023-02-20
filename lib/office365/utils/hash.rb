# frozen_string_literal: true

require "cgi"

class Hash
  def ms_hash_to_query
    query_str = []

    each_pair do |key, value|
      query_str << "#{CGI.escape(key.to_s)}=#{CGI.escape(value.to_s)}"
    end
    query_str.join("&")
  end
end