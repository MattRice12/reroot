Given(/^I have existing trees$/) do
  user = User.create!(name: "User", email: "user@example.com", password: "password")
  Tree.create!(user_id: user.id, name: "Tree 1")
end

Given(/^I have a tree with tabs$/) do
  user = User.create!(name: "User", email: "user@example.com", password: "password")
  tree = Tree.create!(user_id: user.id, name: "Tree 1")
  tab = Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
  Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: tab.id, name: "Tab 2")
end

Given(/^I have an existing project$/) do
  User.create!(name: "User", email: "user@example.com", password: "password")
  Tree.create!(user_id: user.id, name: "Tree 1")
  Project.create!(name: "About Matt", user_id: matt.id)
  Forest.create!(tree_id: tree.id, project_id: project.id)
  Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
end

When(/^I visit "([^"]*)"$/) do |arg1|
  visit(path)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I click "([^"]*)"$/) do |link|
  click_link(link)
end

When(/^I find "([^"]*)"$/) do |id|
  # print page.html
  find_by_id(id)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

When(/^I debug$/) do
  puts page.html
  save_and_open_page
  binding.pry
end

When(/^I upload the test photo$/) do
  attach_file("photo[upload]", Rails.root + "test/fixtures/test_photo.png")
end

Then(/^I should see "([^"]*)"$/) do |content|
  assert page.has_content?(content)
end

Then(/^I should not see "([^"]*)"$/) do |content|
  refute page.has_content?(content)
end

When(/^I press enter in "([^"]*)"$/) do |el|
  page.find(el).send_keys :enter
end

When(/^I check "([^"]*)"$/) do |checkbox|
  page.find(checkbox).click
end
