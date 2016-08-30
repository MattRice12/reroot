Feature: As a User, I would like to be able to see my projects

Background: A User logs in
  Given I have an existing project
    When I visit "/sign_in"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I should see "Your Trees"
    And I should see "ReRoot"

  Scenario: A User sees that he has a project in the User show
    When I click "Users"
    And I click id "User1"
    Then I should see "User1's profile"
    And I should see "Projects:"
    And I should see "Project 1"
    And I should see alt "Leader Image"
    And I should see "1 member"
    And I should see "Total Trees: 1"

  Scenario: A User visits the project page from Users Show
    When I click "Users"
    And I click id "User1"
    And I click "Project 1"
    Then I should see "Project 1"
    And I should see alt "Leader Image"
    And I should see "1 contribution"
    And I should see id "project-edit-button"
    And I should see id "project-delete-button"
    And I should see "Members:"
    And I should see "User1"
    And I should see id "add-member"
    And I should see "Leave Project"
    And I should see "Trees:"
    And I should see id "add-tree"

  Scenario: A User visits the project show from dash
    When I click "Projects"
    And I click "Project 1"
    Then I should see "Project 1"
    And I should see alt "Leader Image"
    And I should see "1 contribution"

  Scenario: A User visits the project index from dash
    When I click "Projects"
    Then I should see "Your Projects"
    And I should see "Project 1"
    And I should see alt "Leader Image"
    And I should see "1 member"
    And I should see "New Project"

  Scenario: A User creates a new project
    When I click "Projects"
    And I click "New Project"
    Then I should see "Start New Project"
    And I fill in "Name" with "Project 2"
    And I press "Create Project"
    Then I should see "Project Created."
    Then I should see "Project 2"
    And I should see "Members:"

  Scenario: A User edits a project
    When I click "Projects"
    And I click "Project 1"
    And I click "project-edit-button"
    Then I should see "Edit Project Name"
    Then I fill in "Name" with "Project 1 edit"
    And I press "Update Project"
    Then I should see "Project Name Updated."
    Then I should see "Project 1 edit"
    And I should see "Members"

  Scenario: A User deletes a project
    When I click "Projects"
    And I click "Project 1"
    And I click "project-delete-button"
    And I should see "The project disbanded."
    And I should see "New Project"

  Scenario: A User adds a member
    When I click "Projects"
    And I click "Project 1"
    And I click "add-member"
    And I press "Create Member"
    Then I should see "User2 has been added to the project!"
    And I should see "User1"
    And I should see "User2"

  Scenario: A User boots a member
    When I click "Projects"
    And I click "Project 1"
    And I click "add-member"
    And I press "Create Member"
    And I click "delete-member"
    Then I should see "User2 has been booted!"

  Scenario: Captain transfers captainship
    When I click "Projects"
    And I click "Project 1"
    And I click "add-member"
    And I press "Create Member"
    And I press "Submit"
    Then I should see "You made User2 the Project Captain."

  Scenario: A User creates a new tree for the project
    When I click "Projects"
    And I click "Project 1"
    And I click "add-tree"
    Then I should see "Create a Tree for this Project"
    And I fill in "tree[name]" with "Tree 2"
    And I press "Create Tree"
    Then I should see "Tree Created and Added to Project."
    And I should see "Tree 2"

  Scenario: A User adds a personal tree to the project
    When I click "Projects"
    And I click "Project 1"
    And I click "delete-tree"
    Then I should see "This tree was removed from the project."
    And I click "add-tree"
    Then I should see "Add Tree"
    And I press "Add Tree"
    Then I should see "Tree Created and Added to Project."
    And I should see "Tree 1"

  Scenario: A User edits a tree in the project
    When I click "Projects"
    And I click "Project 1"
    And I click "edit-tree"
    And I fill in "tree[name]" with "Tree 1 edit"
    And I press "Update Tree"
    Then I should see "Tree Name Updated."
    And I should see "Tree 1 edit"
