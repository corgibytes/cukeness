class HomeController < ApplicationController
  def index
  end
  
  def run_all
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

      redirect_to :controller => :home, :action => :index      
    else
      render :nothing => true, :status => "404"
    end
  end
  
  def cucumber_runner 
    @cucumber_runner
  end
  
  def cucumber_runner=(value)
    @cucumber_runner = value
  end
  
  def cucumber_results
    @cucumber_results
  end
end
