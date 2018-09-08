Feature: Git interactions

  Scenario: Writing Files to a Git Repository
    Given there is an organization named "git" with a project named "interactions"
    And there is a sample git repository with a "features" directory
    And the "git/interactions" project is configured to interact with the sample git respository
    When a new feature named "Writing File Example" is added to the "git/interactions" project with the description:
      """
      This is just an example feature for demonstration purposes.
      """
    And a new scenario titled "The first scenario" is added to the "Writing File Example" feature in the "git/interactions" project with contents:
      """
      Given this
      When that
      Then it will works
      """
    And a new scenario titled "The second scenario" is added to the "Writing File Example" feature in the "git/interactions" project with the contents:
      """
      Given this works
      When that thing happens
      Then everything will be fine
      """
    Then the sample git repository will contain a file named "features/writing-file-example.feature" with contents:
      """
      Feature: Writing File Example

        This is just an example feature for demonstration purposes.

        Scenario: The first scenario
          Given this
          When that
          Then it will works

        Scenario: The second scenario
          Given this works
          When that thing happens
          Then everything will be fine
      """
