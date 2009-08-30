Given /^home is displayed$/ do
  visit '/'
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
  click_link_within "#create_scenario", "Create Scenario"
end

Then /^the feature list should contain a feature named "([^\"]*)"$/ do |arg1|
  pending  
end

Then /^the feature "([^\"]*)" should have a scenario named "([^\"]*)" with body$/ do |arg1, arg2, string|
  pending
end

When /^cancel is clicked$/ do
  pending
end

Then /^the feature list should be empty$/ do
  pending
end

Given /^the feature list contains a feature named "([^\"]*)"$/ do |arg1|
  pending
end

Given /^the feature "([^\"]*)" contains a scenario named "([^\"]*)" with body$/ do |arg1, arg2, string|
  pending
end

Then /^the feature "([^\"]*)" should contain a scenario named "([^\"]*)" with body$/ do |arg1, arg2, string|
  pending
end

