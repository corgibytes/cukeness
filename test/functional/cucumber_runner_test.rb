require 'test_helper'

class CucumberRunnerTest < ActiveSupport::TestCase
  test "run should invoke cucumber command and return output" do
    test_dir = "/tmp/runner_test"
    feature_file_name = test_dir + "/generated.feature"
    steps_file_name = test_dir + "/test_steps.rb"

    if not File.exists? test_dir
      Dir.mkdir test_dir
    end

    delete_file_if_exists feature_file_name
    feature_file = File.open(feature_file_name, "w+")
    feature_file.puts <<eos
Feature: Test feature
  This flavor text should not be outputed
Scenario: Test undefined
When this should be undefined
Scenario: Test passing
When this should pass
Scenario: Test failing
When this should fail
Scenario: Test pending
When this should be pending
eos
    feature_file.close

    delete_file_if_exists steps_file_name
    steps_file = File.open(steps_file_name, "w+")
    steps_file.puts <<eos
When /this should pass/ do
end
When /this should be pending/ do
  pending
end
When /this should fail/ do
  raise 'This should fail'
end
eos
    steps_file.close
    
    runner = CucumberRunner.new test_dir
    output = runner.run
    
    output.should == <<eos
Feature: Feature: Test feature
Scenario: Test undefined
[undefined] When this should be undefined
Scenario: Test passing
[passed] When this should pass
Scenario: Test failing
[failed] When this should fail
Scenario: Test pending
[pending] When this should be pending
eos
  end
end