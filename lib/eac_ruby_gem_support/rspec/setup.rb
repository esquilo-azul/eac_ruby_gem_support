# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_gem_support/rspec/helpers/filesystem'
require 'eac_ruby_gem_support/rspec/helpers/utils'
require 'eac_ruby_gem_support/rspec/specs/rubocop'
require 'tmpdir'

module EacRubyGemSupport
  module Rspec
    module Setup
      extend ::ActiveSupport::Concern
      include ::EacRubyGemSupport::Rspec::Specs::Rubocop

      def self.extended(setup_obj)
        setup_obj.setup_load_path
        setup_obj.setup_example_persistence
        setup_obj.setup_filesystem_helper
      end

      def setup_filesystem_helper
        rspec_config.include ::EacRubyGemSupport::Rspec::Helpers::Filesystem
        rspec_config.include ::EacRubyGemSupport::Rspec::Helpers::Utils
        rspec_config.after(:each) { purge_temp_files }
      end

      def setup_load_path
        $LOAD_PATH.push app_root_path.join('lib').to_path
      end

      def setup_example_persistence
        rspec_config.example_status_persistence_file_path = example_persistence_path.to_path
      end

      # @return [Pathname]
      def example_persistence_path
        root_tmp.join('example_status_persistence')
      end

      # The root directory for temporary files.
      # @return [Pathname]
      def root_tmp
        r = ::Pathname.new(::Dir.tmpdir)
                      .join(app_root_path.expand_path.to_path.variableize + '_specs_tmp')
        r.mkpath unless r.exist?
        r
      end
    end
  end
end
