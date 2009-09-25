module HomeHelper
  def parse_cucumber_output(output)
    result = "<div id=\"features\">\n  <h3>Features:</h3>\n  <div id=\"feature_list\">\n"
    body_opened = false
    output.each_line do |line|
      if line.include? "Feature:"
        if body_opened 
          result << "    </div>\n"
          body_opened = false
        end
        line = line.gsub("Feature:", "").strip
        result << "    <h4>#{line}</h4>\n"
      elsif line.include? "Scenario:"
        if body_opened 
          result << "    </div>\n"
          body_opened = false
        end
        line = line.gsub("Scenario:", "").strip
        result << "    <h5>#{line}</h5>\n    <div class=\"scenario_body\">\n"
        body_opened = true
      elsif line.include? "[undefined]"
        result << "      <span class=\"step undefined\">#{line.strip}</span>\n"
      end
    end
    if body_opened 
      result << "    </div>\n"
      body_opened = false
    end
    result << "  </div>\n</div>\n"
    result
  end
end
