# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_ruby_gem_support/version'

Gem::Specification.new do |s|
  s.name        = 'eac_ruby_gem_support'
  s.version     = EacRubyGemSupport::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Development support for Ruby\' Gem.'
  s.homepage    = 'https://github.com/esquilo-azul/eac_ruby_gem_support'
  s.metadata    = { 'source_code_uri' => 'https://github.com/esquilo-azul/eac_ruby_gem_support' }

  s.files = Dir['{lib}/**/*', '.rubocop.yml']

  s.required_ruby_version = '>= 2.7.0'

  s.add_dependency 'eac_ruby_utils', '~> 0.120'
  s.add_dependency 'rspec', '~> 3.12'
  s.add_dependency 'rubocop', '~> 1.60', '>= 1.60.1'
  s.add_dependency 'rubocop-rails', '~> 2.22', '>= 2.22.1'
  s.add_dependency 'rubocop-rspec', '~> 2.25'
end
