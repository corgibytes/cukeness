class HomeController < ApplicationController
  def index
    if request.post? 
      if File.directory? steps_dir
        feature_file_generator.generate
        @cucumber_results = cucumber_runner.run
      else
        @error_message = "The steps location setting refers to a path that does not exist or is not a directory. Please change the setting and try again."
      end
    else
      @steps_location_exists = steps_location_setting != nil
    end
  end
  
  def cucumber_runner 
    if not @cucumber_runner 
      @cucumber_runner = CucumberRunner.new steps_dir
    end
      
    @cucumber_runner
  end
  
  def cucumber_runner=(value)
    @cucumber_runner = value
  end
  
  def feature_file_generator
    if not @feature_file_generator
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
  
  def steps_location_setting
    Setting.find_by_name("steps_location")
  end
  
  def steps_dir 
    steps_location_setting.value
  end
  
  def steps_location_exists
    @steps_location_exists
  end
  
  def error_message
    @error_message
  end
end
