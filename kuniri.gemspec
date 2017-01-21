# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kuniri/version'

Gem::Specification.new 'kuniri', '0.2' do |spec|
  spec.name          = "kuniri"
  spec.version       = Kuniri::VERSION
  spec.authors       = ["Gustavo Jaruga", "Rodrigo Siqueira"]
  spec.email         = ["darksshades@hotmail.com", "siqueira@kuniri.org"]
  spec.summary       = %q{Extract class information from code.}
  spec.description   = 'Generic parser'
  spec.homepage      = "http://kuniri.github.io/kuniri/"
  spec.license       = "LGPLv3"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["kuniri"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "rake", "~> 10.0"
end
