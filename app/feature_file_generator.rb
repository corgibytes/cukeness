class FeatureFileGenerator
  def initialize(steps_location)
    @steps_location = steps_location
  end
  
  def generate
    delete_previously_generated_files
    
    features = Feature.all
    features.each_with_index do |feature, index|
      feature_file = File.open(@steps_location + "/generated_#{index + 1}.feature", "w+")
      feature_file.puts "Feature: #{feature.name}"
      feature.scenarios.each do |scenario|
        feature_file.puts "Scenario: #{scenario.name}"
        feature_file.puts scenario.body
      end
      feature_file.close
    end
  end
  
  private
    def delete_previously_generated_files
      Dir.foreach(@steps_location) do |file_name|
        if /generated_\d+\.feature/.match(file_name)
          File.delete @steps_location + "/" + file_name
        end
      end
    end
end