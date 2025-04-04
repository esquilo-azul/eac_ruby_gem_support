# frozen_string_literal: true

require 'eac_ruby_utils/core_ext'

module EacRubyGemSupport
  # Lists pairs of source/target files in a directory.
  class SourceTargetFixtures
    class << self
      def source_target_basename(file)
        m = /^(.+)\.(?:source|target)(?:\..+)?$/.match(File.basename(file))
        m ? m[1] : nil
      end
    end

    # @!attribute [r] fixtures_directory
    #   @return [String]

    # @!method initialize(fixtures_directory)
    #   @param fixtures_directory [Pathname]
    common_constructor :fixtures_directory

    def source_target_files
      sources_targets_basenames.map do |basename|
        ::EacRubyGemSupport::SourceTargetFixtures::SourceTargetFile.new(self, basename)
      end
    end

    def source_files
      r = []
      source_target_files.each do |st|
        r << st.source if st.source
      end
      r
    end

    def target_files
      r = []
      source_target_files.each do |st|
        r << st.target if st.target
      end
      r
    end

    def target_file(basename)
      fixture_file(basename, 'target')
    end

    def source_file(basename)
      fixture_file(basename, 'source')
    end

    private

    def fixture_file(basename, suffix)
      prefix = "#{basename}.#{suffix}"
      Dir.foreach(fixtures_directory) do |item|
        next if %w[. ..].include?(item)
        return File.expand_path(item, fixtures_directory) if item.starts_with?(prefix)
      end
      nil
    end

    def sources_targets_basenames
      basenames = Set.new
      Dir.foreach(fixtures_directory) do |item|
        next if %w[. ..].include?(item)

        b = self.class.source_target_basename(item)
        basenames << b if b.present?
      end
      basenames
    end
  end
end
