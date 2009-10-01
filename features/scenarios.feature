Feature: Scenarios
  As a cucumber user
  I want to store scenarios in a repository
  So that they are easy to create and modify by business users
  
  Scenario: Add a scenario
    Given the step location setting is set to "tmp/steps"
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
    Given the step location setting is set to "tmp/steps"
    Given home is displayed
    And the feature list is empty
    When add scenario is clicked
    And cancel is clicked
    Then the feature list should be empty
    
  Scenario: Add a scenario to an existing feature
    Given the step location setting is set to "tmp/steps"
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
    
    Scenario: Clicking add scenario displays modal dialog box
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list is empty
      And the add scenario dialog is not visible
      When add scenario is clicked
      Then the add scenario dialog is visible
      
    Scenario: Clicking cancel hides the modal dialog box
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list is empty
      And the add scenario dialog is not visible
      When add scenario is clicked
      And cancel is clicked
      Then the add scenario dialog is not visible
        
    Scenario: Clicking create scenario hides the model dialog box
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list is empty
      And the add scenario dialog is not visible
      When add scenario is clicked
      And "calculator" is typed as the feature name
      And "subtract" is typed as the scenario name
      And the scenario body is typed as 
        """
        When - is clicked
        """
      And create scenario is clicked
      Then the add scenario dialog is not visible
      
    Scenario: Run undefined step
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And the step definitions are located at "tmp/steps"
      When run scenarios is clicked
      Then mark the step "When + is clicked" as undefined
      
    Scenario: Run pending step
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And the step definitions are located at "tmp/steps"        
      And glue exists for the step "+ is clicked" that invokes pending
      When run scenarios is clicked
      Then mark the step "When + is clicked" as pending
      
    Scenario: Run a passing step
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And the step definitions are located at "tmp/steps"        
      And glue exists for the step "+ is clicked"
      When run scenarios is clicked
      Then mark the step "When + is clicked" as passed
      
    Scenario: Run a failing step
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And the step definitions are located at "tmp/steps"        
      And glue exists for the step "+ is clicked" that fails
      When run scenarios is clicked
      Then mark the step "When + is clicked" as failed
      And display the failure message below the step "When + is clicked"
      
    Scenario: Running multiple features
      Given the step location setting is set to "tmp/steps"
      Given home is displayed
      And the feature list contains a feature named "Calculator"
      And the feature "Calculator" contains a scenario named "Add" with body
        """
        When + is clicked
        """
      And the feature list contains a feature named "Other Feature"
      And the feature "Other Feature" contains a scenario named "The Scenario" with body
        """
        When something happens
        """
      When run scenarios is clicked 
      Then mark the step "When + is clicked" as undefined
      And mark the step "When something happens" as undefined
      
    Scenario: Setting steps location is required on first run
      Given there are no settings 
      When home is displayed
      Then the settings dialog should be visible
      And the steps location box should be empty
      And the steps location box should be marked as required
    
    Scenario: Setting dialog should not display if there is a steps location value
      Given the step location setting is set to "tmp/steps"
      When home is displayed 
      Then the settings dialog should not be visible
      
    Scenario: Setting directory must exist when run is clicked
      Given the steps location setting is set to a directory that does not exist
      When run scenarios is clicked
      Then an error message should be displayed with text
        """
        The steps location setting refers to a path that does not exist or is not a directory. Please change the setting and try again.
        """