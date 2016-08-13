# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create!(name: "admin", email: "admin@example.com", password: "password")
tree = Tree.create!(user_id: user.id)

tab = Tab.create(user_id: user.id, tree_id: tree.id) #only 1 tab can have a nil parent_tab_id per tree

2.times do
  tab2 = Tab.create!(user_id: user.id, tree_id: tree.id, parent_tab_id: tab.id)
  tab3 = Tab.create!(user_id: user.id, tree_id: tree.id, parent_tab_id: tab2.id)
  Tab.create!(user_id: user.id, tree_id: tree.id, parent_tab_id: tab3.id)
end
