require 'cucumber/formatter/console'

class CukenessFormatter < Cucumber::Ast::Visitor
  include Cucumber::Formatter::Console
  
  def initialize(step_mother, io, options)
    super(step_mother)
    @io = io
  end
  
  def visit_feature_name(name)
    first_line = nil
    name.each_line do |line|
      if not first_line
        first_line = line
      end
    end
    
    @io.puts "#{first_line}"
  end
  
  def visit_scenario_name(keyword, name, file_colon_line, source_indent)
    @io.puts "Scenario: #{name}"
  end
  
  def visit_step_result(keyword, step_match, multiline_arg, status, exception, source_indent, background)
    @io.puts "[#{status}] #{keyword} #{step_match.format_args(nil)}"
  end
end