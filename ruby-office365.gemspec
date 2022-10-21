# frozen_string_literal: true

require_relative "lib/office365/version"

Gem::Specification.new do |spec|
  spec.name = "ruby-office365"
  spec.version = Office365::VERSION
  spec.authors = ["Encore Shao"]
  spec.email = ["encore@ekohe.com"]

  spec.summary = "A simple ruby library to interact with Microsoft Graph and Office 365 API."
  spec.description = "A simple ruby library to interact with Microsoft Graph and Office 365 API."
  spec.homepage = "https://github.com/ekohe/ruby-office365"
  spec.required_ruby_version = ">= 2.5.0"
  spec.license = "MIT"
  spec.post_install_message = "Thanks for installing!"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ekohe/ruby-office365"
  spec.metadata["changelog_uri"] = "https://github.com/ekohe/ruby-office365/blob/main/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"

  # VCR for testing APIs
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  # Rubocop
  spec.add_development_dependency "rubocop"
  # For debug binding.pry
  spec.add_development_dependency "pry"
  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
