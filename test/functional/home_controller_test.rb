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
  
  test "get to index will indicate that the steps location setting has not been set" do
    get :index
    
    @controller.steps_location_exists.should == false
  end
  
  test "get to index will indicate that the steps location setting has been set" do
    steps_location = "/tmp/steps"
    setting = Setting.new
    setting.name = "steps_location"
    setting.value = steps_location
    setting.save

    get :index
    
    @controller.steps_location_exists.should == true
  end
  
  test "post to index will display an error message if the steps location does not exist" do
    steps_location = "/does/not/exist"
    setting = Setting.new
    setting.name = "steps_location"
    setting.value = steps_location
    setting.save
    
    post :index, {}
    
    @controller.error_message.should == 
      "The steps location setting refers to a path that does not exist or is not a directory. Please change the setting and try again."
  end
end
