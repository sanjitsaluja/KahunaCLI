# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'KahunaCLI/version'

Gem::Specification.new do |spec|
  spec.name          = "KahunaCLI"
  spec.version       = KahunaCLI::VERSION
  spec.authors       = ["Sanjit Saluja"]
  spec.email         = ["loopwhile1@gmail.com"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Command line interface for Kahuna APIs.}
  spec.homepage      = "https://github.com/sanjitsaluja/KahunaClient"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_dependency 'hashie'
  spec.add_dependency 'thor'
  spec.add_dependency 'colorize'
  spec.add_dependency 'kahuna_client'
end
