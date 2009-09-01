Given /^home is displayed$/ do
  visit "/"
end

Given /^the feature list is empty$/ do
  Feature.destroy_all
end

When /^add scenario is clicked$/ do
  click_link "Add Scenario"
end

When /^"([^\"]*)" is typed as the feature name$/ do |feature_name|
  within "#create_scenario" do 
    fill_in "feature_name", :with => feature_name
  end
end

When /^"([^\"]*)" is typed as the scenario name$/ do |scenario_name|
  within "#create_scenario" do
    fill_in "scenario_name", :with => scenario_name
  end
end

When /^the scenario body is typed as$/ do |scenario_body|
  within "#create_scenario" do
    fill_in "scenario_body", :with => scenario_body
  end
end

When /^create scenario is clicked$/ do
  within "#create_scenario" do 
    click_button "Create Scenario"
  end
end

Then /^the feature list should contain a feature named "([^\"]*)"$/ do |feature_name|
  response_body.should have_selector "div#features" do |feature_div|
    feature_div.should have_selector "h3", :content => "Features:"
    feature_div.should have_selector "div#feature_list" do |feature_list_div|
      feature_list_div.should have_selector "h4", :content => feature_name
    end 
  end
end

Then /^the feature "([^\"]*)" should have a scenario named "([^\"]*)" with body$/ do |feature_name, scenario_name, scenario_body|
  response_body.should have_selector "div#features" do |feature_div|
    feature_div.should have_selector "h3", :content => "Features:"
    feature_div.should have_selector "div#feature_list" do |feature_list_div|
      feature_list_div.should have_selector "h4", :content => feature_name
      feature_list_div.should have_selector "h5", :content => scenario_name
      feature_list_div.should have_selector "div.scenario_body", :content => scenario_body
    end 
  end
end

When /^cancel is clicked$/ do
  within "#create_scenario" do 
    click_button "Cancel"
  end
end

Then /^the feature list should be empty$/ do
  response_body.should have_selector "div#features" do |feature_div|
    feature_div.should have_selector "h3", :content => "Features:"
    feature_div.should have_selector "div#feature_list", :content => ""
  end
end

Given /^the feature list contains a feature named "([^\"]*)"$/ do |feature_name|
  feature = Feature.create :name => feature_name
  feature.save
end

Given /^the feature "([^\"]*)" contains a scenario named "([^\"]*)" with body$/ do |feature_name, scenario_name, scenario_body|
  feature = Feature.find(:first, :conditions => "name = '#{feature_name}'")
  scenario = Scenario.create :name => scenario_name, :body => scenario_body
  scenario.feature = feature
  scenario.save
end

When /^run scenarios is clicked$/ do
  pending
end

Then /^mark the step "([^\"]*)" as undefined$/ do |arg1|
  pending
end

Given /^glue exists for the step "([^\"]*)" that invokes pending$/ do |arg1|
  pending
end

Then /^mark the step "([^\"]*)" as pending$/ do |arg1|
  pending
end

Given /^glue exists for the step "([^\"]*)"$/ do |arg1|
  pending
end

Then /^mark the step "([^\"]*)" as passed$/ do |arg1|
  pending
end

Given /^glue exists for the step "([^\"]*)" that fails$/ do |arg1|
  pending
end

Then /^mark the step "([^\"]*)" as failed$/ do |arg1|
  pending
end

Then /^display the failure message below the step "([^\"]*)"$/ do |arg1|
  pending
end



