# frozen_string_literal: true

require 'eac_ruby_gem_support/rspec/helpers/filesystem'
require 'eac_ruby_gem_support/rspec/specs/rubocop'
require 'rspec'

module EacRubyGemSupport
  class Rspec
    include ::EacRubyGemSupport::Rspec::Specs::Rubocop

    class << self
      def default
        @default || raise("Default instance was not set. Use #{self.class.name}.setup")
      end

      def setup(app_root_path, config = nil)
        @default = if config
                     new(app_root_path, config)
                   else
                     ::RSpec.configure { |new_config| new(app_root_path, new_config) }
                   end
      end
    end

    attr_reader :app_root_path, :config

    def initialize(app_root_path, config)
      @app_root_path = app_root_path
      @config = config
      setup
    end

    protected

    def setup
      setup_filesystem_helper
    end

    def setup_filesystem_helper
      config.include ::EacRubyGemSupport::Rspec::Helpers::Filesystem
      config.after(:each) { purge_temp_files }
    end
  end
end
