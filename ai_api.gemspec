# frozen_string_literal: true

require_relative "lib/ai_api/version"

Gem::Specification.new do |spec|
  spec.name = "ai_api"
  spec.version = AIApi::VERSION
  spec.authors = ["RDeckard"]
  spec.email = ["rdeckard.gt@gmail.com"]

  spec.summary = "Ruby wrapper for several AI providers' APIs"
  spec.homepage = "https://github.com/RDeckard/ai_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2"

  spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RDeckard/ai_api"
  spec.metadata["changelog_uri"] = "https://github.com/RDeckard/ai_api/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.20"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
