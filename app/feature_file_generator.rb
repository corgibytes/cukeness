class FeatureFileGenerator
  def initialize(steps_location)
    @steps_location = steps_location
  end
  
  def generate
    feature_file = File.open(@steps_location + "/generated.feature", "w+")
  
    features = Feature.all
    features.each do |feature|
      feature_file.puts "Feature: #{feature.name}"
      feature.scenarios.each do |scenario|
        feature_file.puts "Scenario: #{scenario.name}"
        feature_file.puts scenario.body
      end
    end
  
    feature_file.close
  end
end