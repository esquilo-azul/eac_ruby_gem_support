# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'
require 'eac_ruby_gem_support/rspec/helpers/filesystem'
require 'eac_ruby_gem_support/rspec/specs/rubocop'

module EacRubyGemSupport
  class Rspec
    module SetupInclude
      common_concern do
        include ::EacRubyGemSupport::Rspec::Specs::Rubocop
      end

      class << self
        def setup(setup_obj)
          setup_filesystem_helper(setup_obj)
        end

        private

        def setup_filesystem_helper(setup_obj)
          setup_obj.rspec_config.include ::EacRubyGemSupport::Rspec::Helpers::Filesystem
          setup_obj.rspec_config.after(:each) { purge_temp_files }
        end
      end
    end
  end
end
