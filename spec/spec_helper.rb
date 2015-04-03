require 'simplecov'
SimpleCov.start

require_relative '../lib/toy_robot'

RSpec.configure do |config|
  
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.order = "random"

end

RSpec::Matchers.define :have_constant do |const|
  match do |owner|
    owner.const_defined?(const)
  end
end

RSpec::Matchers.define :match_stdout do |check|

  @capture = nil

  match do |block|

    begin
      stdout_saved = $stdout
      $stdout      = StringIO.new
      block.call
    ensure
      @capture     = $stdout
      $stdout      = stdout_saved
    end

    @capture.string.match check
  end

  failure_message do
    "expected to #{description}"
  end
  failure_message_when_negated do
    "expected not to #{description}"
  end
  description do
    "match [#{check}] on stdout [#{@capture.string}]"
  end

  def supports_block_expectations?
    true
  end
end