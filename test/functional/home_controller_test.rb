require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "run all will ask cucumber to run all scenarios" do
    feature = Feature.new
    feature.name = "Test Feature"
    feature.save
    
    scenario = Scenario.new
    scenario.name = "Test Scenario"
    scenario.feature = feature
    scenario.body = "When something happens"
    scenario.save
    
    setting = Setting.new
    setting.name = "steps_location"
    setting.value = "/tmp/steps"
    
    if File::exists? "/tmp/steps"
      Dir.rmdir "/tmp/steps"
    end
    Dir.mkdir "/tmp/steps"
    
    cucumber_runner = CucumberRunner.new
    @controller.cucumber_runner = cucumber_runner
    
    cucumber_runner.stub!(:run).and_return("cucumber results")
    
    post :run_all, {}
    
    @controller.cucumber_results.should == "cucumber results"
    
    File.exists?("/tmp/steps/generated.feature").should be_true
    
    file = File.open("/tmp/steps/generated.feature", "r")
    file_lines = file.readlines
    
    file_lines[0].should == "Feature: Test Feature"
    file_lines[1].should == "Scenario: Test Scenario"
    file_lines[2].should == "When something happens"
  end
end
