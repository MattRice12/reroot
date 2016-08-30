Feature: As a user, I should be able to sign up

Scenario: User signs up
  When I visit "/sign_in"
  And I click "Sign Up"
  And I fill in "user[name]" with "User1"
  And I fill in "user[email]" with "user1@example.com"
  And I fill in "user[password]" with "password"
  And I press "Submit"
  Then I should see "User1"
  And I should see "Your Trees"

Scenario: User doesn't input information
  When I visit "sign_in"
  And I click "Sign Up"
  And I press "Submit"
  Then I should see "Errors: Unable to create Account."
