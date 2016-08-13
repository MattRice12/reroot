# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create!(name: "admin", email: "admin@example.com", password: "password")
tree = Tree.create!(user_id: user)
3.times do
  branch = Branch.create(user_id: user, tree_id: tree)
  3.times do
    Tab.create(user_id: user, branch_id: branch)
  end
end
