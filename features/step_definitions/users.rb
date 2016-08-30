Given(/^I have a set of users with trees$/) do
  user = User.create!(name: "User1", email: "user@example.com", password: "password")
    tree = Tree.create!(user_id: user.id, name: "Tree 1")
      Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 1")
      Tab.create!(user_id: user.id, tree_id: tree.id, url: "www.google.com", parent_tab_id: nil, name: "Tab 2")
    Tree.create!(user_id: user.id, name: "Tree 2")

  user2 = User.create!(name: "User2", email: "user2@example.com", password: "password")
    Tree.create!(user_id: user2.id, name: "Tree 3")

  User.create!(name: "User3", email: "user3@example.com", password: "password")
end
