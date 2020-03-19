# frozen_string_literal: true

$LOAD_PATH.push File.expand_path('lib', __dir__)

require 'eac_ruby_gem_support/version'

Gem::Specification.new do |s|
  s.name        = 'eac_ruby_gem_support'
  s.version     = ::EacRubyGemSupport::VERSION
  s.authors     = ['Esquilo Azul Company']
  s.summary     = 'Development support for Ruby\' Gem.'
  s.homepage    = 'https://github.com/esquilo-azul/eac_ruby_gem_support'
  s.metadata    = { 'source_code_uri' => 'https://github.com/esquilo-azul/eac_ruby_gem_support' }

  s.files = Dir['{lib}/**/*']

  s.add_dependency 'rubocop', '~> 0.80.1'
end
