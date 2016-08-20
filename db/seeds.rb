# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

url = "http://rubyonrails.org/"

user = User.create!(name: "Ender",
                    email: "Ender@example.com",
                    password: "password")

User.create!(name: "Bean", email: "bean@example.com", password: "password")
User.create!(name: "Petra", email: "petra@example.com", password: "password")
User.create!(name: "Alai", email: "alai@example.com", password: "password")
User.create!(name: "Dink", email: "dink@example.com", password: "password")

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

  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(2..7),
                url: url,
                name: "#{rand(1..100)}")
  end

  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(7..10),
                url: url,
                name: "#{rand(1..100)}")
  end

  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(11..14),
                url: url,
                name: "#{rand(1..100)}")
  end
  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(15..18),
                url: url,
                name: "#{rand(1..100)}")
  end
  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(19..22),
                url: url,
                name: "#{rand(1..100)}")
  end
  3.times do
    Tab.create!(user_id: user.id,
                tree_id: tree.id,
                parent_tab_id: rand(23..26),
                url: url,
                name: "#{rand(1..100)}")
  end
  tree = tree2
end

Project.create!(name: "Dragon Army", user_id: 1)
Project.create!(name: "Rabbit Army", user_id: 2)
Project.create!(name: "Salamander Army", user_id: 3)
Project.create!(name: "Phoenix Army", user_id: 4)
Project.create!(name: "Rat Army", user_id: 5)


Member.create!(user_id: 1, project_id: 1)
Member.create!(user_id: 2, project_id: 1)
Member.create!(user_id: 2, project_id: 2)
Member.create!(user_id: 3, project_id: 3)
Member.create!(user_id: 4, project_id: 4)
Member.create!(user_id: 5, project_id: 5)

Forest.create!(tree_id: 1, project_id: 1)
