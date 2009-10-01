Before do
  [Scenario, Feature, Setting].each do |model|
    model.delete_all
  end
end

Given /^home is displayed$/ do
  $browser.goto @host + "/"
end

Given /^the feature list is empty$/ do
  Feature.find(:all).empty?.should be_true
  Scenario.find(:all).empty?.should be_true
end

When /^add scenario is clicked$/ do
  $browser.button(:text, "Add Scenario").click
end

When /^"([^\"]*)" is typed as the feature name$/ do |feature_name|
  $browser.div(:id => "create_scenario").
    text_field(:name => "feature_name").
      value = feature_name
end

When /^"([^\"]*)" is typed as the scenario name$/ do |scenario_name|
  $browser.div(:id => "create_scenario").
    text_field(:name => "scenario_name").
      value = scenario_name
end

When /^the scenario body is typed as$/ do |scenario_body|
  $browser.div(:id => "create_scenario").
    text_field(:name => "scenario_body").
      value = scenario_body
end

When /^create scenario is clicked$/ do
  $browser.button(:text => "Create Scenario").click
end

Then /^the feature list should contain a feature named "([^\"]*)"$/ do |feature_name|
  feature_div = $browser.div(:id, "features")
  feature_div.h3(:index, 1).text.should == "Features:"
  
  feature_list_div = feature_div.div(:id => "feature_list")
  feature_list_div.h4(:index, 1).text.should == feature_name
end

Then /^the feature "([^\"]*)" should have a scenario named "([^\"]*)" with body$/ do |feature_name, scenario_name, scenario_body|
  feature_div = $browser.div(:id, "features")
  feature_div.h3(:index, 1).text.should == "Features:"

  feature_list_div = feature_div.div(:id => "feature_list")
  feature_list_div.h4(:index, 1).text.should == feature_name
  feature_list_div.h5(:text, scenario_name).should_not be_nil
  feature_list_div.div(:text, scenario_body).should_not be_nil
end

When /^cancel is clicked$/ do
  $browser.button(:text => "Cancel").click
end

Then /^the feature list should be empty$/ do
  feature_div = $browser.div(:id, "features")
  feature_div.h3(:index, 1).text.should == "Features:"

  feature_list_div = feature_div.div(:id => "feature_list").text.should == ""
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
  $browser.button(:text, "Run Scenarios").click
end

Given /^the step definitions are located at "([^\"]*)"$/ do |steps_location|
  if not File::exists? steps_location 
    Dir.mkdir steps_location
  end
  setting = Setting.new
  setting.name = "steps_location"
  setting.value = steps_location
  setting.save
end

Given /^glue exists for the step "([^\"]*)" that invokes pending$/ do |step|
  write_step_file <<-eos
When /#{step}/ do
  pending
end
eos
end

Given /^glue exists for the step "([^\"]*)"$/ do |step|  
  write_step_file <<-eos
When /#{step}/ do
end
eos
end

Given /^glue exists for the step "([^\"]*)" that fails$/ do |step|
  write_step_file <<-eos
When /#{step}/ do
  raise 'This should fail'
end
eos
end

def write_step_file(contents)
  contents = contents.gsub("+", "\\\\+")
  
  steps_location = Setting.find_by_name("steps_location").value
  
  steps_file_name = steps_location + "/test_steps.rb"
  if File::exists? steps_file_name
    File.delete steps_file_name  
  end
  steps_file = File.new(steps_file_name, "w+")
  steps_file.puts contents
  steps_file.close  
end

Then /^mark the step "([^\"]*)" as undefined$/ do |step|
  $browser.html.include?("<span class=\"step undefined\">[undefined] #{step}</span>").should be_true
end

Then /^mark the step "([^\"]*)" as pending$/ do |arg1|
  $browser.html.include?("<span class=\"step pending\">[pending] #{step}</span>").should be_true
end

Then /^mark the step "([^\"]*)" as passed$/ do |arg1|
  $browser.html.include?("<span class=\"step passed\">[passed] #{step}</span>").should be_true
end

Then /^mark the step "([^\"]*)" as failed$/ do |arg1|
  $browser.html.include?("<span class=\"step failed\">[failed] #{step}</span>").should be_true
end

Then /^display the failure message below the step "([^\"]*)"$/ do |arg1|
  pending
end

Given /^the add scenario dialog is not visible$/ do
  $browser.div(:id, "create_scenario").visible?.should be_false
end

Then /^the add scenario dialog is visible$/ do
  $browser.div(:id, "create_scenario").visible?.should be_true
end

Given /^there are no settings$/ do
  Setting.delete_all
end

Given /^the step location setting is set to "([^\"]*)"$/ do |steps_location_value|
  setting = Setting.find_by_name("steps_location")
  if not setting
    setting = Setting.new
    setting.name = "steps_location"
  end  
  
  setting.value = steps_location_value
  setting.save
end

Then /^the settings dialog should be visible$/ do
  $browser.div(:id, "edit_settings").visible?.should be_true
end

Then /^the settings dialog should not be visible$/ do
  $browser.div(:id, "edit_settings").visible?.should be_false
end

Then /^the steps location box should be empty$/ do
  pending
end

Then /^the steps location box should be marked as required$/ do
  pending
end

Given /^the steps location setting is set to a directory that does not exist$/ do
  pending
end

Then /^an error message should be displayed with text$/ do |string|
  pending
end





