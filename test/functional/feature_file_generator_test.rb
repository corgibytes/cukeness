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
    generated_feature_file = steps_location + '/generated.feature'
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
    
    steps_location = "/tmp/steps"    
    generated_feature_file = steps_location + '/generated.feature'
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
end