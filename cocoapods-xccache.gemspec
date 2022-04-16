# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cocoapods-xccache/gem_version.rb'

Gem::Specification.new do |spec|
  spec.name          = 'cocoapods-xccache'
  spec.version       = CocoapodsXccache::VERSION
  spec.authors       = ['faimin']
  spec.email         = ['fuxianchao@gmail.com']
  spec.description   = %q{A short description of cocoapods-xccache.}
  spec.summary       = %q{A longer description of cocoapods-xccache.}
  spec.homepage      = 'https://github.com/EXAMPLE/cocoapods-xccache'
  spec.license       = 'MIT'

  #spec.files         = `git ls-files`.split($/)
  spec.files         = Dir['lib/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'xcodeproj', '~> 1.19'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
