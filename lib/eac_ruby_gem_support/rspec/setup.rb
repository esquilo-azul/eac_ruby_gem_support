# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_gem_support/rspec/helpers/filesystem'
require 'eac_ruby_gem_support/rspec/specs/rubocop'
require 'tmpdir'

module EacRubyGemSupport
  module Rspec
    class Setup
      common_constructor :setup_obj

      def perform
        setup_obj.singleton_class.include ::EacRubyGemSupport::Rspec::Specs::Rubocop
        setup_load_path
        setup_example_persistence
        setup_filesystem_helper
      end

      private

      def setup_filesystem_helper
        setup_obj.rspec_config.include ::EacRubyGemSupport::Rspec::Helpers::Filesystem
        setup_obj.rspec_config.after(:each) { purge_temp_files }
      end

      def setup_load_path
        $LOAD_PATH.push setup_obj.app_root_path.join('lib').to_path
      end

      def setup_example_persistence
        setup_obj.rspec_config.example_status_persistence_file_path =
          example_persistence_path.to_path
      end

      # @return [Pathname]
      def example_persistence_path
        ::File.join(::Dir.tmpdir, setup_obj.app_root_path.basename.to_path.variableize).to_pathname
      end
    end
  end
end
