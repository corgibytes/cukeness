class HomeController < ApplicationController
  def index
    if request.post? 
      steps_dir = Setting.find_by_name("steps_location").value
      feature_file = File.open(steps_dir + "/generated.feature", "w+")
    
      features = Feature.all
      features.each do |feature|
        feature_file.puts "Feature: #{feature.name}"
        feature.scenarios.each do |scenario|
          feature_file.puts "Scenario: #{scenario.name}"
          feature_file.puts scenario.body
        end
      end
    
      feature_file.close
    
      @cucumber_results = cucumber_runner.run
    end
  end
  
  def cucumber_runner 
    if not @cucumber_runner 
      steps_dir = Setting.find_by_name("steps_location").value
      @cucumber_runner = CucumberRunner.new steps_dir
    end
      
    @cucumber_runner
  end
  
  def cucumber_runner=(value)
    @cucumber_runner = value
  end
  
  def cucumber_results
    @cucumber_results
  end
end
