Feature: As a User, I would like to be able to see my trees

Background: A User logs in
  Given I have existing trees
    When I visit "/sign_in"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I should see "Your Trees"
    Then I should see "Tree 1"
    And I should see "ReRoot"
