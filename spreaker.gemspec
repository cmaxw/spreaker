# frozen_string_literal: true

require_relative "lib/spreaker/version"

Gem::Specification.new do |spec|
  spec.name = "spreaker"
  spec.version = Spreaker::VERSION
  spec.authors = ["Charles Max Wood"]
  spec.email = ["chuck@topenddevs.com"]

  spec.summary = "An API Wrapper Library for Spreaker"
  spec.description = "Manage your podcasts at episodes on Spreaker with this gem."
  spec.homepage = "https://github.com/cmaxw/spreaker"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/cmaxw/spreaker"
  spec.metadata["changelog_uri"] = "https://github.com/cmaxw/spreaker/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "faraday", "~> 2.7.11"
  spec.add_dependency "faraday-retry", "~> 2.2.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
