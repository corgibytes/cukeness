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
    
    steps_location = "/tmp/steps"
    setting = Setting.new
    setting.name = "steps_location"
    setting.value = steps_location
    setting.save

    generated_feature_file = steps_location + '/generated.feature'
    create_directory_if_missing steps_location
    delete_file_if_exists generated_feature_file
    
    cucumber_runner = CucumberRunner.new steps_location
    @controller.cucumber_runner = cucumber_runner
    
    cucumber_runner.stub!(:run).and_return("cucumber results")
    
    post :run_all, {}
    
    @controller.cucumber_results.should == "cucumber results"
    
    File.exists?(generated_feature_file).should == true
    
    file = File.open(generated_feature_file, "r")
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
