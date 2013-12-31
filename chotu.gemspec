# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'chotu/version'

Gem::Specification.new do |spec|
  spec.name          = "chotu"
  spec.version       = Chotu::VERSION
  spec.authors       = ["Nishant Modak"]
  spec.email         = ["modak.nishant@gmail.com"]
  spec.description   = %q{A gem description}
  spec.summary       = %q{A gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rack"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "http_parser.rb"
end
