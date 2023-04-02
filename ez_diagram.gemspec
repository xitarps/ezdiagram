# frozen_string_literal: true

require_relative 'lib/ez_diagram/version'

Gem::Specification.new do |spec|
  spec.name = 'ez_diagram'
  spec.version = EzDiagram::VERSION
  spec.authors = ['XitaRps']
  spec.email = ['xitarps@gmail.com']

  spec.summary = 'A gem made to crate easily a class diagram'
  spec.description = "A gem made to crate easily a class diagram with methods like: 'has_many'"
  spec.homepage = 'https://still-to-come.com'
  spec.required_ruby_version = '>= 3.2.1'

  spec.metadata['allowed_push_host'] = 'Still to come...'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://still-to-come.com'
  spec.metadata['changelog_uri'] = 'https://still-to-come.com'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
