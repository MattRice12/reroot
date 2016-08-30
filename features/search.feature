Feature: As a user, I would like to search tabs

Background: A User logs in
  Given I have a tree with a tab
    When I visit "/sign_in"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I should see "Your Trees"
    And I should see "ReRoot"

  Scenario: I search for Tab 1
    And I fill in "search" with "tab"
    And I press "Search"
    Then I should see "Tab 1"
