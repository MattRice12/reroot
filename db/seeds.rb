# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

url = "http://rubyonrails.org/"
name = %w(ender bean petra alai dink)
tab_name = ["Main Branch", "Main Branch", "Child", "Child", "Grandchild", "Grandchild", "Great Grandchild", "Great Grandchild"]
proj_name = ["Dragon Army", "Rabbit Army", "Salamander Army", "Phoenix Army", "Rat Army"]

t = 1
5.times do
  User.create!(name: name[t - 1].capitalize, email: "#{name[t - 1]}@example.com", password: "password")
  Project.create!(name: proj_name[t - 1], user_id: t)
  Member.create!(user_id: t, project_id: t)
  t += 1
end
Member.create!(user_id: 1, project_id: 2)
Member.create!(user_id: 2, project_id: 1)

user = User.first
t = 1
2.times do
  Tree.create!(user_id: user.id, name: "Tree: #{t.to_s}")
  Forest.create!(tree_id: t, project_id: 1)

  Tab.create(user_id: user.id,
             tree_id: t,
             url: url,
             name: tab_name[t - 1]) #only 1 tab can have a nil parent_tab_id per tree
  3.times do
    Tab.create!(user_id: user.id,
                parent_tab_id: t,
                url: url,
                name: tab_name[t - 1])
    t += 2
  end
  t = 2
end

50.times do
  t = Tab.all.count
  Tab.create!(user_id: user.id,
              parent_tab_id: rand(((t - 4) / 2)..t),
              url: url,
              name: "#{rand(1..100)}")
end
