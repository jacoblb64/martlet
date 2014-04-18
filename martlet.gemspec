# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'martlet/version'

Gem::Specification.new do |spec|
  spec.name          = "martlet"
  spec.version       = Martlet::VERSION
  spec.authors       = ["Alex Coco"]
  spec.email         = ["hello@alexcoco.com"]
  spec.description   = %q{Ruby client for McGill's student portal, Minerva.}
  spec.summary       = %q{Client for McGill's student portal}
  spec.homepage      = "https://github.com/alexcoco/martlet"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  
  spec.add_dependency "mechanize", "~> 2.7"
  spec.add_dependency "thor", "~> 0.19.1"
end
