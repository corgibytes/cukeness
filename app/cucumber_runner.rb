require "open3"

class CucumberRunner
  def initialize(directory)
    @steps_directory = directory
  end
  
  def run
    cukeness_formatter_file_name = File.dirname(__FILE__) + "/cukeness_formatter.rb"
    command = "cucumber --format CukenessFormatter -r #{cukeness_formatter_file_name} -r #{@steps_directory} #{@steps_directory}/generated.feature"
    
    stdin, stdout, stderr = Open3.popen3(command)
    
    error_lines = all_lines_from stderr
    if error_lines.length > 0
      raise error_lines
    end
    
    all_lines_from stdout
  end
  
  def all_lines_from(stream)
    all_lines = ""
    
    if not stream.closed?
      lines = stream.readlines
      lines.each do |line|
        all_lines << line
      end
    end
    
    all_lines
  end
end