# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'payture/ewallet/version'

Gem::Specification.new do |spec|
  spec.name          = 'payture-ewallet'
  spec.version       = Payture::Ewallet::VERSION
  spec.authors       = ['Roman Khrebtov']
  spec.email         = ['roman@alltmb.ru']

  spec.summary       = 'Ruby wrapper for Payture eWallet API'
  spec.description   = 'Ruby wrapper for Payture eWallet API'
  spec.homepage      = 'https://github.com/busfor/payture-ewallet'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9'
  spec.add_dependency 'money', '~> 6.9'
  spec.add_dependency 'multi_xml', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.51'
  spec.add_development_dependency 'simplecov', '~> 0.14'
  spec.add_development_dependency 'vcr', '~> 2.9'
  spec.add_development_dependency 'webmock', '~> 3.0'
end
