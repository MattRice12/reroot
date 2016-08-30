Feature: As a User, I would like to be able to see other users

Background: A User logs in
  Given I have a set of users with trees
    When I visit "/sign_in"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I should see "Your Trees"
    And I should see "ReRoot"

  Scenario: A User visits the user index
    When I click "Users"
    Then I should see "Users"
    And I should see "User1"
    And I should see "User2"
    And I should see "User3"

  Scenario: A User views another User's profile
    When I click "Users"
    And I click id "User1"
    Then I should see "User1's profile"
    And I should see "Projects:"
    And I should see "None"
    And I should see "User1's stats"
    And I should see "Total Trees: 2"
    And I should see "Total Tabs: 2"
    And I click "Users"
    And I click id "User2"
    And I should see "Projects:"
    And I should see "None"
    And I should see "User2's stats"
    And I should see "Total Trees: 1"
    And I should see "Total Tabs: 0"
