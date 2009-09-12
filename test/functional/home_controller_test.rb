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
      Directory.rmdir "/tmp/steps"
    end
    Directory.mkdir "/tmp/steps"
    
    @controller.cucumber_runner = FakeCucumberRunner.new
    
    post :run_all, {}
    
  end
end
