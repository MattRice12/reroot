Given(/^I have an existing project$/) do
  User.create!(name: "User", email: "user@example.com", password: "password")
  Tree.create!(user_id: user.id, name: "Tree 1")
  Project.create!(name: "About Matt", user_id: matt.id)
  Forest.create!(tree_id: tree.id, project_id: project.id)
  Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
end
