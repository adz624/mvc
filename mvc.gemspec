# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mvc/version'

Gem::Specification.new do |spec|
  spec.name          = "mvc"
  spec.version       = Mvc::VERSION
  spec.authors       = ["eddie.li"]
  spec.email         = ["eddie@visionbundles.com"]
  spec.summary       = %q{light mvc framework}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '~> 3.0.0'
  spec.add_development_dependency 'database_cleaner'
  spec.add_development_dependency 'sqlite3'
end