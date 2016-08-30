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

When(/^I click id "([^"]*)"$/) do |id|
  find_by_id(id).click
end

When(/^I debug$/) do
  # puts page.html
  save_and_open_page
  # binding.pry
end

Then(/^I should see "([^"]*)"$/) do |content|
  assert page.has_content?(content)
end

Then(/^I should see alt "([^"]*)"$/) do |alt|
  find("img[alt='#{alt}']")
end

Then(/^I should see id "([^"]*)"$/) do |id|
  assert page.has_link?(id)
end

Then(/^I should not see "([^"]*)"$/) do |content|
  refute page.has_content?(content)
end

Then(/^I find "([^"]*)"$/) do |el|
  page.find(el)
end
