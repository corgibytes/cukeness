require 'test_helper'

class FeatureFileGeneratorTest < ActiveSupport::TestCase
  test "generate should produce a feature file" do
    feature = Feature.new
    feature.name = "Test Feature"
    feature.save
    
    scenario = Scenario.new
    scenario.name = "Test Scenario"
    scenario.feature = feature
    scenario.body = "When something happens"
    scenario.save
    
    steps_location = "/tmp/steps"    
    generated_feature_file = steps_location + '/generated_1.feature'
    create_directory_if_missing steps_location
    delete_file_if_exists generated_feature_file
    
    feature_file_generator = FeatureFileGenerator.new steps_location
    feature_file_generator.generate
    
    File.exists?(generated_feature_file).should == true
    
    file = File.open(generated_feature_file, "r")
    file_lines = file.readlines
    
    file_lines[0].should == "Feature: Test Feature\n"
    file_lines[1].should == "Scenario: Test Scenario\n"
    file_lines[2].should == "When something happens\n"
  end
  
  test "two features should result in two feature files" do
    feature = Feature.new
    feature.name = "Test Feature"
    feature.save
    
    scenario = Scenario.new
    scenario.name = "Test Scenario"
    scenario.feature = feature
    scenario.body = "When something happens"
    scenario.save
    
    second_feature = Feature.new
    second_feature.name = "Second Feature"
    second_feature.save
    
    second_scenario = Scenario.new
    second_scenario.name = "Second Scenario"
    second_scenario.feature = second_feature
    second_scenario.body = "When something else happens"
    second_scenario.save
    
    steps_location = "/tmp/steps"    
    
    first_generated_feature_file = steps_location + '/generated_1.feature'
    second_generated_feature_file = steps_location + '/generated_2.feature'
    create_directory_if_missing steps_location
    delete_file_if_exists first_generated_feature_file
    delete_file_if_exists second_generated_feature_file
    
    feature_file_generator = FeatureFileGenerator.new steps_location
    feature_file_generator.generate
    
    File.exists?(first_generated_feature_file).should == true
        
    first_file = File.open(first_generated_feature_file, "r")
    first_file_lines = first_file.readlines
    
    first_file_lines[0].should == "Feature: Test Feature\n"
    first_file_lines[1].should == "Scenario: Test Scenario\n"
    first_file_lines[2].should == "When something happens\n"
    
    File.exists?(second_generated_feature_file).should == true
        
    second_file = File.open(second_generated_feature_file, "r")
    second_file_lines = second_file.readlines
    
    second_file_lines[0].should == "Feature: Second Feature\n"
    second_file_lines[1].should == "Scenario: Second Scenario\n"
    second_file_lines[2].should == "When something else happens\n"
  end
  
  test "generator removes all previously generated feature files before it runs" do
    steps_location = "/tmp/steps"    
    
    first_existing_feature_file = steps_location + '/generated_1.feature'
    second_existing_feature_file = steps_location + '/generated_2.feature'
    
    create_directory_if_missing steps_location
    touch_file first_existing_feature_file
    touch_file second_existing_feature_file
    
    feature = Feature.new
    feature.name = "Test Feature"
    feature.save
    
    scenario = Scenario.new
    scenario.name = "Test Scenario"
    scenario.feature = feature
    scenario.body = "When something happens"
    scenario.save
    
    feature_file_generator = FeatureFileGenerator.new steps_location
    feature_file_generator.generate
    
    File.exists?(first_existing_feature_file).should == true
    File.exists?(second_existing_feature_file).should == false
  end
  
  def touch_file(path)
    File.new(path, "w+")
  end
end