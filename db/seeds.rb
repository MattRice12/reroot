# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.create!(name: "admin", email: "admin@example.com", password: "password")
Tree.create!(user_id: 1)

3.times do
  branch = Branch.create(user_id: 1, tree_id: 1)
  tab = Tab.create!(user_id: 1, branch_id: branch.id)
  tab2 = Tab.create!(user_id: 1, branch_id: branch.id, parent_tab_id: tab.id)
  Tab.create!(user_id: 1, branch_id: branch.id, parent_tab_id: tab2.id)
end
