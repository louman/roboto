# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'toy_robot/version'

Gem::Specification.new do |spec|
  spec.name          = "toy_robot"
  spec.version       = ToyRobot::VERSION
  spec.authors       = ["louman"]
  spec.email         = ["marcus.v.mansur@gmail.com"]

  spec.summary       = %q{Toy Robot Test}
  spec.description   = %q{Toy Robot Test}
  spec.homepage      = "https://github.com/louman/toy_robot"

  spec.files         = `git ls-files`.split("\n")
  spec.bindir        = "bin"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
  spec.add_development_dependency "simplecov", "~> 0.9.2"

end
