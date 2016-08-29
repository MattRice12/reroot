Given(/^I have existing trees$/) do
  user = User.create!(name: "User", email: "user@example.com", password: "password")
  Tree.create!(user_id: user.id, name: "Tree 1")
end

When(/^I visit "([^"]*)"$/) do |arg1|
  visit(path)
end

When(/^I fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, with: value)
end

When(/^I click "([^"]*)"$/) do |link|
  click_link(link)
  # print page.html
end

When(/^I find id "([^"]*)"$/) do |id|
  # print page.html
  find_by_id(id)
end

When(/^I press "([^"]*)"$/) do |button|
  click_button(button)
end

When(/^I click on "([^"]*)"$/) do |el|
  find(el).click
end

When(/^I debug$/) do
  # puts page.html
  save_and_open_page
  # binding.pry
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

Then(/^Under "([^"]*)" I input "([^"]*)" with "([^"]*)"$/) do |arg1, arg2, arg3|
  page.find(arg1).fill_in(arg2, with: arg3)
end

Then(/^I find "([^"]*)"$/) do |el|
  page.find(el)
end
