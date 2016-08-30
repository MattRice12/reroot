Given(/^I have an existing project$/) do
  user = User.create!(name: "User1", email: "user@example.com", password: "password")
  User.create!(name: "User2", email: "user2@example.com", password: "password")
  tree = Tree.create!(user_id: user.id, name: "Tree 1")
  project = Project.create!(name: "Project 1", user_id: user.id)
  Member.create!(user_id: user.id, project_id: project.id)
  Forest.create!(tree_id: tree.id, project_id: project.id)
  Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
end
