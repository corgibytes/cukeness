require 'test_helper'

class ScenariosControllerTest < ActionController::TestCase
  # Replace this with your real tests.
  test "create action will create a new feature and a new scenario" do
    post :create, { 
      :feature_name => "New Feature", 
      :scenario_name => "New Scenario", 
      :scenario_body => "New Body" }
    
    feature = Feature.find(:first, :conditions => "name = 'New Feature'")
    assert_not_nil feature
    
    assert_equal "New Feature", feature.name
    assert_equal "New Scenario", feature.scenarios[0].name
    assert_equal "New Body", feature.scenarios[0].body
    
    assert_redirected_to :controller => :home, :action => :index
  end
  
  test "create action should not respond to get" do
    get :create
    assert_response :missing
  end
end
