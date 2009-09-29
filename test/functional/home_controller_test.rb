require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "post to index will ask cucumber to run all scenarios" do
    steps_location = "/tmp/steps"
    setting = Setting.new
    setting.name = "steps_location"
    setting.value = steps_location
    setting.save

    feature_file_generator = FeatureFileGenerator.new steps_location
    @controller.feature_file_generator = feature_file_generator
    
    cucumber_runner = CucumberRunner.new steps_location
    @controller.cucumber_runner = cucumber_runner
    
    cucumber_runner.stub!(:generate)
    cucumber_runner.stub!(:run).and_return("cucumber results")
    
    post :index, {}
    
    @controller.cucumber_results.should == "cucumber results"    
  end
end
