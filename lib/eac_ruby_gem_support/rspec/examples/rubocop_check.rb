# frozen_string_literal: true

require 'rubocop'
require 'rspec'

RSpec.shared_examples 'rubocop_check' do |root_path|
  before do
    ::RuboCop::ConfigLoader.ignore_parent_exclusion = true
  end

  let(:root_path) { root_path }
  let(:config_store) do
    r = ::RuboCop::ConfigStore.new
    r.for(root_path)
    r
  end
  let(:runner) { ::RuboCop::Runner.new({}, config_store) }

  it 'rubocop return ok' do
    expect(::Dir.chdir(root_path) { runner.run([]) }).to eq(true)
  end
end
