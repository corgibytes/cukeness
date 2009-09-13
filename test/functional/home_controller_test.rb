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
    setting.save
    
    if File::exists? "/tmp/steps"
      File.delete "/tmp/steps/generated.feature"
      Dir.rmdir "/tmp/steps"
    end
    Dir.mkdir "/tmp/steps"
    
    cucumber_runner = CucumberRunner.new
    @controller.cucumber_runner = cucumber_runner
    
    cucumber_runner.stub!(:run).and_return("cucumber results")
    
    post :run_all, {}
    
    @controller.cucumber_results.should == "cucumber results"
    
    File.exists?("/tmp/steps/generated.feature").should == true
    
    file = File.open("/tmp/steps/generated.feature", "r")
    file_lines = file.readlines
    
    file_lines[0].should == "Feature: Test Feature\n"
    file_lines[1].should == "Scenario: Test Scenario\n"
    file_lines[2].should == "When something happens\n"
    
    assert_redirected_to :controller => :home, :action => :index
  end
  
  test "run_all action should not respond to get" do
    get :run_all
    
    assert_response :missing
  end
end
