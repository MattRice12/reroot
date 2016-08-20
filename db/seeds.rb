# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

url = "http://rubyonrails.org/"

user = User.create!(name: "admin",
                    email: "admin@example.com",
                    password: "password")

tree = Tree.create!(user_id: user.id, name: "Tree: 1")
tree2 = Tree.create!(user_id: user.id, name: "Tree: 2")

2.times do
  tab = Tab.create(user_id: user.id,
                   tree_id: tree.id,
                   url: url,
                   name: "Main Branch") #only 1 tab can have a nil parent_tab_id per tree

  2.times do
    tab2 = Tab.create!(user_id: user.id,
                       tree_id: tree.id,
                       parent_tab_id: tab.id,
                       url: url,
                       name: "Child")

    tab3 = Tab.create!(user_id: user.id,
                       tree_id: tree.id,
                       parent_tab_id: tab2.id,
                       url: url,
                       name: "Grandchild")

    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: tab3.id,
                url: url,
                name: "Great Grandchild")
  end

  10.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(2..7),
                url: url,
                name: "#{rand(1..100)}")
  end

  10.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(7..17),
                url: url,
                name: "#{rand(1..100)}")
  end
  tree = tree2
end

Project.create!(name: "Dragon Army", user_id: 1)

Member.create!(user_id: 1, project_id: 1)
