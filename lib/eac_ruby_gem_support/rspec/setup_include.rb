# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_gem_support/rspec/helpers/filesystem'
require 'eac_ruby_gem_support/rspec/specs/rubocop'
require 'tmpdir'

module EacRubyGemSupport
  module Rspec
    module SetupInclude
      common_concern do
        include ::EacRubyGemSupport::Rspec::Specs::Rubocop
      end

      class << self
        def setup(setup_obj)
          setup_load_path(setup_obj)
          setup_example_persistence(setup_obj)
          setup_filesystem_helper(setup_obj)
        end

        private

        def setup_filesystem_helper(setup_obj)
          setup_obj.rspec_config.include ::EacRubyGemSupport::Rspec::Helpers::Filesystem
          setup_obj.rspec_config.after(:each) { purge_temp_files }
        end

        def setup_load_path(setup_obj)
          $LOAD_PATH.push setup_obj.app_root_path.join('lib').to_path
        end

        def setup_example_persistence(setup_obj)
          setup_obj.rspec_config.example_status_persistence_file_path =
            setup_obj.example_persistence_path.to_path
        end
      end

      # @return [Pathname]
      def example_persistence_path
        ::File.join(::Dir.tmpdir, app_root_path.basename.to_path.variableize).to_pathname
      end
    end
  end
end
