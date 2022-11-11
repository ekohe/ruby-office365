# frozen_string_literal: true

class String
  def rails_underscore
    gsub(/::/, "/")
      .gsub(/@/, "")
      .gsub(/\./, "_")
      .gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2')
      .gsub(/([a-z\d])([A-Z])/, '\1_\2')
      .tr("-", "_")
      .downcase
  end

  # rubocop:disable Style/SymbolProc
  def rails_camelize(uppercase_first_letter: false)
    string = self
    return string if string !~ /_/ && string =~ /[A-Z]+.*/

    string = if uppercase_first_letter
               string.sub(/^[a-z\d]*/) { |match| match.capitalize }
             else
               string.sub(/^(?:(?=\b|[A-Z_])|\w)/) { |match| match.downcase }
             end
    string.gsub(%r{(?:_|(/))([a-z\d]*)}) { "#{::Regexp.last_match(1)}#{::Regexp.last_match(2).capitalize}" }.gsub("/", "::")
  end
  # rubocop:enable Style/SymbolProc
end
