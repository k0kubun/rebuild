# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rebuild/version'

Gem::Specification.new do |spec|
  spec.name          = "rebuild"
  spec.version       = Rebuild::VERSION
  spec.authors       = ["Takashi Kokubun"]
  spec.email         = ["takashikkbn@gmail.com"]
  spec.summary       = %q{Full-automatic command line tools installer for OSX Yosemite}
  spec.description   = %q{This gem allows you to achieve mouse-free command line tools installation in OSX Yosemite. Then `rebuild` clones your GitHub repository and runs all of your bootstrap scripts. Thus you can setup or synchronize your environment by just executing `rebuild [username]/[project]`.}
  spec.homepage      = "https://github.com/k0kubun/rebuild"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "pry", "~> 0.10.1"
  spec.add_development_dependency "bundler", "~> 1.7.4"
  spec.add_development_dependency "rake", "~> 10.0"
end
