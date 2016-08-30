Feature: As a User, I would like to be able to see my first tree and tabs

Background: A User logs in
  Given I have a tree with a tab
    When I visit "/sign_in"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I should see "Your Trees"
    And I should see "ReRoot"

  Scenario: I see my first tree
    And I should see "Tree 1"

  Scenario: I create a second tree
    And I click "new-tree-button"
    Then I should see "Create Tree"
    And I should see "Tree name"
    And I fill in "tree[name]" with "Tree 2"
    And I press "Create Tree"
    Then I should see "ReRoot"
    And I should see "Your Trees"
    And I should see "Tree 1"
    And I should see "Tree 2"

  Scenario: I edit a tree
    And I click "edit-tree"
    Then I should see "Edit Name"
    And I should see "Tree name"
    And I fill in "tree[name]" with "Tree 2"
    And I press "Update Tree"
    Then I should see "ReRoot"
    And I should see "Tree Name Updated"
    And I should not see "Tree 1"
    And I should see "Tree 2"

  Scenario: I delete a tree
    And I click "delete-tree"
    Then I should not see "Tree 1"
    Then I should see "You have no trees"
