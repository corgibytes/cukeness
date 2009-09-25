require 'test_helper'

class HomeHelperTest < ActionView::TestCase
  test "parse_cucumber_output should read undefined" do
    input = <<-eos
Feature: Calculator
Scenario: Add
[undefined] When + is clicked
eos
    
    expected = <<-eos
<div id="features">
  <h3>Features:</h3>
  <div id="feature_list">
    <h4>Calculator</h4>
    <h5>Add</h5>
    <div class="scenario_body">
      <span class="step undefined">[undefined] When + is clicked</span>
    </div>
  </div>
</div>
eos
    
    parse_cucumber_output(input).should == expected
  end
  
  test "parse_cucumber_output should read pending" do
    input = <<-eos
Feature: Calculator
Scenario: Add
[pending] When + is clicked
eos

    expected = <<-eos
<div id="features">
  <h3>Features:</h3>
  <div id="feature_list">
    <h4>Calculator</h4>
    <h5>Add</h5>
    <div class="scenario_body">
      <span class="step pending">[pending] When + is clicked</span>
    </div>
  </div>
</div>
eos

    parse_cucumber_output(input).should == expected
  end
  
  test "parse_cucumber_output should read passed" do
    input = <<-eos
Feature: Calculator
Scenario: Add
[passed] When + is clicked
eos

    expected = <<-eos
<div id="features">
  <h3>Features:</h3>
  <div id="feature_list">
    <h4>Calculator</h4>
    <h5>Add</h5>
    <div class="scenario_body">
      <span class="step passed">[passed] When + is clicked</span>
    </div>
  </div>
</div>
eos

    parse_cucumber_output(input).should == expected
  end

  test "parse_cucumber_output should read failed" do
    input = <<-eos
Feature: Calculator
Scenario: Add
[failed] When + is clicked
eos

    expected = <<-eos
<div id="features">
  <h3>Features:</h3>
  <div id="feature_list">
    <h4>Calculator</h4>
    <h5>Add</h5>
    <div class="scenario_body">
      <span class="step failed">[failed] When + is clicked</span>
    </div>
  </div>
</div>
eos

    parse_cucumber_output(input).should == expected
  end

end
