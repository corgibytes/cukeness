class HomeController < ApplicationController
  def index
    if request.post? 
      steps_dir = Setting.find_by_name("steps_location").value
      
      feature_file_generator.generate
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
  
  def feature_file_generator
    if not @feature_file_generator
      steps_dir = Setting.find_by_name("steps_location").value
      @feature_file_generator = FeatureFileGenerator.new steps_dir
    end
    
    @feature_file_generator
  end
  
  def feature_file_generator=(value)
    @feature_file_generator = value
  end
  
  def cucumber_results
    @cucumber_results
  end
end
