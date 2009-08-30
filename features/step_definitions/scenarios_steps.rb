Given /^home is displayed$/ do
  visit '/'
end

Given /^the feature list is empty$/ do
  Feature.destroy_all
end

When /^add scenario is clicked$/ do
  click_link "Add Scenario"
end

When /^"([^\"]*)" is typed as the feature name$/ do |arg1|
  pending
end

When /^"([^\"]*)" is typed as the scenario name$/ do |arg1|
  pending
end

When /^the scenario body is typed as$/ do |string|
  pending
end

When /^create scenario is clicked$/ do
  pending
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

