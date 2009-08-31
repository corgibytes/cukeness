Feature: Scenarios
  As a cucumber user
  I want to store scenarios in a repository
  So that they are easy to create and modify by business users
  
  Scenario: Add a scenario
    Given home is displayed
    And the feature list is empty
    When add scenario is clicked
    And "calculator" is typed as the feature name
    And "add" is typed as the scenario name
    And the scenario body is typed as
      """
      When + is clicked
      """
    And create scenario is clicked
    Then the feature list should contain a feature named "calculator"
    And the feature "calculator" should have a scenario named "add" with body
      """
      When + is clicked
      """
    
  Scenario: Cancel an add
    Given home is displayed
    And the feature list is empty
    When add scenario is clicked
    And cancel is clicked
    Then the feature list should be empty
    
  Scenario: Add a scenario to an existing feature
    Given home is displayed
    And the feature list contains a feature named "calculator"
    And the feature "calculator" contains a scenario named "add" with body
      """
      When + is clicked
      """
    When add scenario is clicked
    And "calculator" is typed as the feature name
    And "subtract" is typed as the scenario name
    And the scenario body is typed as 
      """
      When - is clicked
      """
    And create scenario is clicked
    Then the feature list should contain a feature named "calculator"
    And the feature "calculator" should have a scenario named "add" with body
      """
      When + is clicked
      """
    And the feature "calculator" should have a scenario named "subtract" with body
      """
      When - is clicked
      """
