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
      
    Scenario: Run undefined step
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      When run scenarios is clicked
      Then mark the step "When + is clicked" as undefined
      
    Scenario: Run pending step
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And glue exists for the step "When + is clicked" that invokes pending
      When run scenarios is clicked
      Then mark the step "When + is clicked" as pending
      
    Scenario: Run a passing step
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And glue exists for the step "When + is clicked"
      When run scenarios is clicked
      Then mark the step "When + is clicked" as passed
      
    Scenario: Run a failing step
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And glue exists for the step "When + is clicked" that fails
      When run scenarios is clicked
      Then mark the step "When + is clicked" as failed
      And display the failure message below the step "When + is clicked"