Given(/^I have a tree with a tab$/) do
  user = User.create!(name: "User", email: "user@example.com", password: "password")
  tree = Tree.create!(user_id: user.id, name: "Tree 1")
  Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
end
