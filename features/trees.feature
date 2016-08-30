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

  Scenario: I create a second tree but don't put in a name
    And I click "new-tree-button"
    And I press "Create Tree"
    Then I should see "Name can't be blank"
    
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
    Then I should see "Tree Destroyed."
    And I should not see "Tree 1"
    And I should see "You have no trees"

  Scenario: I view the Tree show page
    And I click "Tree 1"
    Then I should see "Tree 1"
    And I should see "Tab 1"
    And I should see "Tree stats:"
    And I should see "Tree 1 is used in 0 projects."
    And I should see "Tree 1 has 0 branches."
    And I should see "Tree 1 has 1 tab."

  Scenario: I delete a tree from the show page
    And I click "Tree 1"
    And I click "delete-tree"
    Then I should see "Tree Destroyed."
    And I should see "You have no trees"

  Scenario: I edit a tree from the show page
    And I click "Tree 1"
    And I click "edit-tree"
    And I press "Update Tree"
    Then I should see "Tree Name Updated."
