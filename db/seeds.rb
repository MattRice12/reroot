# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# url = "http://rubyonrails.org/"
# name = %w(ender bean petra alai dink)
# tab_name = ["Main Branch", "Main Branch", "Child", "Child", "Grandchild", "Grandchild", "Great Grandchild", "Great Grandchild"]
# proj_name = ["Dragon Army", "Rabbit Army", "Salamander Army", "Phoenix Army", "Rat Army"]

websites = { github:
              {
                ["GitHub", "https://github.com/"] =>
                  [
                    ["Tab-Tree", "https://github.com/MattRice12/tab-tree"],
                    ["Filecabinet", "https://github.com/MattRice12/filecabinet"],
                    ["Best Food Trucks", "https://github.com/MattRice12/bft-project"]
                  ]
              },

             heroku:
              {
                ["Heroku", "https://dashboard.heroku.com/apps"] =>
                  [
                    ["Blueit", "https://blueit.herokuapp.com/"],
                    ["Tab-it", "https://tab-it.herokuapp.com/"]
                  ]
              },

             medium:
              {
                ["Medium - Matt Rice", "https://medium.com/@mattrice12"] =>
                  [
                    ["Medium - How to Database-ic Girl", "https://medium.com/@mattrice12/how-to-database-ic-girl-7ae256565584#.8ygm9ybzp"]
                  ]
              },

             linkedin: ["LinkedIn", "https://www.linkedin.com/"],
             trello: ["Trello", "https://trello.com/b/1FkkSslY/tab-tree"],
             facebook: ["Facebook - Matt Rice", "https://www.facebook.com/matt.rice.106"],
             twitter: ["Twitter", "https://twitter.com/?lang=en"],
             bp: ["Brain Pickings", "https://www.brainpickings.org/"],
             tiy: ["The Iron Yard", "https://www.theironyard.com/"]
           }

matt = User.create!(name: "Matt", email: "matt@example.com", password: "password")
project = Project.create!(name: "About Matt", user_id: matt.id)
tree = Tree.create!(user_id: matt.id, name: "Matt's Websites")
Forest.create!(tree_id: tree.id, project_id: project.id)
Tab.create!(user_id: matt.id,
            tree_id: tree.id,
            url: "https://github.com/",
            parent_tab_id: nil,
            name: "Matt")

n = 0

websites.keys.count.times do
  k1 = websites.keys[n] ####### first hash key (symbol)
  if websites[k1].is_a?(Hash)
    k2 = websites[k1].keys[0] ### second hash key (array)
     ### array set

    tab = Tab.create!(user_id: matt.id,
                tree_id: tree.id,
                parent_tab_id: 1,
                url:  k2[1],
                name: k2[0])

    t = 0
    if websites[k1][k2].is_a?(Array)
      arr_set = websites[k1][k2]
      arr_set.count.times do
        Tab.create!(user_id: matt.id,
                    tree_id: tree.id,
                    parent_tab_id: tab.id,
                    url:  arr_set[t][1],
                    name: arr_set[t][0])

        t += 1
      end
    end
  else
    Tab.create!(user_id: matt.id,
                tree_id: nil,
                parent_tab_id: 1,
                url:  websites[k1][1],
                name: websites[k1][0])
  end
  n += 1
end




coding_sites =

            { ["coding - Google Search", "https://www.google.com/#q=coding"] =>
              { ["Coding - Wikipedia", "https://en.wikipedia.org/wiki/Coding"] =>
                {
                  ["Entropy encoding - Wikipedia", "https://en.wikipedia.org/wiki/Entropy_encoding"] =>
                    [
                     ["Lossless compression - Wikipedia", "https://en.wikipedia.org/wiki/Lossless_compression"],
                     ["Information Theory - Wikipedia", "https://en.wikipedia.org/wiki/Information_theory"]
                    ],


                  ["Computer Programming - Wikipedia", "https://en.wikipedia.org/wiki/Computer_programming"] =>
                    { ["Algorithmic efficiency - Wikipeda", "https://en.wikipedia.org/wiki/Algorithmic_efficiency"] =>
                      { ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache"] =>
                        [
                          { ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache#Cache_performance"] =>
                            [
                              ["Program counter - Wikipedia", "https://en.wikipedia.org/wiki/Program_counter"],
                              { ["Cache algorithms - Wikipedia", "https://en.wikipedia.org/wiki/Cache_algorithms"] =>
                                { ["Distributed cache - Wikipedia", "https://en.wikipedia.org/wiki/Distributed_cache"] =>
                                  {
                                    ["Database caching", "https://en.wikipedia.org/wiki/Database_caching"] =>
                                      [
                                        { ["Database - Wikipedia", "https://en.wikipedia.org/wiki/Database"] =>
                                          [
                                            ["PostgreSQL - Wikipedia", "https://en.wikipedia.org/wiki/PostgreSQL"],
                                            ["Oracle Database - Wikipedia", "https://en.wikipedia.org/wiki/Oracle_Database"],
                                            ["MySQL - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"]
                                          ]
                                        },
                                        ["Database schema - Wikipedia", "https://en.wikipedia.org/wiki/Database_schema"]#,
                                        # ["Table (database) - Wikipedia", "https://en.wikipedia.org/wiki/Table_(database)"],
                                        # ["Query language - Wikipedia", "https://en.wikipedia.org/wiki/Query_language"],
                                        # ["View (SQL) - Wikipedia", "https://en.wikipedia.org/wiki/View_(SQL)"]
                                      ]
                                  }
                                }
                              }
                            ]
                          },
                          { ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache#DCACHE"] =>
                            { ["Memory management unit - Wikipedia", "https://en.wikipedia.org/wiki/Memory_management_unit"] =>
                               { ["Server (computing) - Wikipedia", "https://en.wikipedia.org/wiki/Memory_management_unit"] =>
                                 [
                                   { ["Database server - Wikipedia", "https://en.wikipedia.org/wiki/Database_server"] =>
                                     [
                                       ["Front and back ends - Wikipedia", "https://en.wikipedia.org/wiki/Front_and_back_ends"],
                                       { ["MySQL - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"] =>
                                         [
                                           ["Tortious interference - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"],
                                           ["SQL - Wikipedia", "https://en.wikipedia.org/wiki/SQL"],
                                           ["Cloud database - Wikipedia", "https://en.wikipedia.org/wiki/Cloud_database"]
                                         ]
                                       },
                                       { ["CSVs", "https://en.wikipedia.org/wiki/Comma-separated_values"] =>
                                           [["Data exchange - Wikipedia", "https://en.wikipedia.org/wiki/Data_exchange"]]
                                       }
                                     ]
                                   },
                                   ["Data structure diagram - Wikipedia", "https://en.wikipedia.org/wiki/Data_structure_diagram"],
                                   ["Proxy server - Wikipedia", "https://en.wikipedia.org/wiki/Proxy_server"]
                                 ]
                               }
                            }
                          }
                          ]
                      }
                    }
                  }
                }
              }

def tab!(url:, name:, parent_id: nil)
  Tab.create!(user_id: user.id, tree_id: tree.id, parent_tab_id: parent_id, url: url, name: name)
end

def parse(tree, parent_id = nil)
  case tree
  when Array
    tab!(url: tree.last, name: tree.first, parent_id: parent_id)
  when Hash
    tree.each do |(k, v)|
      t = tab!(url: k.last, name: k.first, parent_id: parent_id)
      case v
      when Array
        v.each do |elem|
          parse(elem, t.id)
        end
      when Hash
        parse(v, t.id)
      else
        fail "Unexpected data type, should be hash or array"
      end
    end
  else
    fail "Unexpected data type, should be hash or array"
  end
end

#    ["Google", "www.google.com"],                                                                  #0   \    \                 1
#      ["coding - Google Search", "https://www.google.com/#q=coding"],                                #1  / 0   \               2
#        ["Codng - Wikipedia", "https://en.wikipedia.org/wiki/Coding"],                                 #2  / 1 \               3
#          ["Entropy encoding - Wikipedia", "https://en.wikipedia.org/wiki/Entropy_encoding"],            #32 / 2   \           4
#            ["Lossless compression - Wikipedia", "https://en.wikipedia.org/wiki/Lossless_compression"],    #33 / 32  \         5
#            ["Information Theory - Wikipedia", "https://en.wikipedia.org/wiki/Information_theory"],        #34 / 32  \         6
#
#        ["Computer Programming - Wikipedia", "https://en.wikipedia.org/wiki/Computer_programming"],    #3  / 2       \         7
#         ["Algorithmic efficiency - Wikipeda", "https://en.wikipedia.org/wiki/Algorithmic_efficiency"], #4  / 3      \         8
#           ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache"],                           #5  / 4    \         9
#             ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache#Cache_performance"],         #6  / 5  \         10
#               ["Program counter - Wikipedia", "https://en.wikipedia.org/wiki/Program_counter"],              #7  / 6  \       11
#               ["Cache algorithms - Wikipedia", "https://en.wikipedia.org/wiki/Cache_algorithms"],            #8  / 6  \       12
#                 ["Distributed cache - Wikipedia", "https://en.wikipedia.org/wiki/Distributed_cache"],          #9  / 8  \     13
#                  ["Database caching", "https://en.wikipedia.org/wiki/Database_caching"],                        #23 / 9   \   14
#                    ["Database - Wikipedia", "https://en.wikipedia.org/wiki/Database"],                            #24 / 23  \ 15
#                      ["PostgreSQL - Wikipedia", "https://en.wikipedia.org/wiki/PostgreSQL"],                        #25 / 24 \16
#                      ["Oracle Database - Wikipedia", "https://en.wikipedia.org/wiki/Oracle_Database"],              #26 / 24 \17
#                      ["MySQL - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"],                                  #27 / 24 \18
#                    ["Database schema - Wikipedia", "https://en.wikipedia.org/wiki/Database_schema"],              #28 / 23  \ 19
#                    ["Table (database) - Wikipedia", "https://en.wikipedia.org/wiki/Table_(database)"],            #29 / 23  \ 20
#                    ["Query language - Wikipedia", "https://en.wikipedia.org/wiki/Query_language"],                #30 / 23  \ 21
#                    ["View (SQL) - Wikipedia", "https://en.wikipedia.org/wiki/View_(SQL)"],                        #31 / 23  \ 22
#
#        ["CPU cache - Wikipeda", "https://en.wikipedia.org/wiki/CPU_cache#DCACHE"],                    #10 / 5               \ 23
#           ["Memory management unit - Wikipedia", "https://en.wikipedia.org/wiki/Memory_management_unit"],#11 / 10           \ 24
#             ["Server (computing) - Wikipedia", "https://en.wikipedia.org/wiki/Memory_management_unit"],    #12 / 11         \ 25
#               ["Database server - Wikipedia", "https://en.wikipedia.org/wiki/Database_server"],              #13 / 12       \ 26
#                 ["Front and back ends - Wikipedia", "https://en.wikipedia.org/wiki/Front_and_back_ends"],      #14 / 13     \ 27
#                 ["MySQL - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"],                                  #15 / 13     \ 28
#                   ["Tortious interference - Wikipedia", "https://en.wikipedia.org/wiki/MySQL"],                  #16 / 15   \ 29
#                   ["SQL - Wikipedia", "https://en.wikipedia.org/wiki/SQL"],                                      #19 / 15   \ 30
#                   ["Cloud database - Wikipedia", "https://en.wikipedia.org/wiki/Cloud_database"],                #20 / 15   \ 31
#                 ["CSVs", "https://en.wikipedia.org/wiki/Comma-separated_values"],                              #17 / 13     \ 32
#                    ["Data exchange - Wikipedia", "https://en.wikipedia.org/wiki/Data_exchange"],                  #18 / 17  \ 33
#
#                 ["Data structure diagram - Wikipedia", "https://en.wikipedia.org/wiki/Data_structure_diagram"],#21 / 13     \ 34
#                 ["Proxy server - Wikipedia", "https://en.wikipedia.org/wiki/Proxy_server"],                    #22 / 13     \ 35
#              ]

# def hash_loops(user, tree, p_id, key, value, count)
#
#     Tab.create!(user_id: user.id,
#                 tree_id: tree.id,
#                 parent_tab_id: p_id,
#                 url:  key[1],
#                 name: key[0])
#
#     if value.is_a?(Hash)
#       count = 0
#       p_id += 1
#       value.each do |k2, v2|
#         count += 1
#         hash_loops(user, tree, p_id, k2, v2, count)
#       end
#
#     elsif value.is_a?(Array)
#       p_id += 1
#       value.each do |val|
#         if val.is_a?(Array)
#           # val.each do |v|
#             Tab.create!(user_id: user.id,
#                         tree_id: tree.id,
#                         parent_tab_id: p_id,
#                         url:  v[1],
#                         name: v[0])
#           # end
#         count += 1
#         else
#           key = val.keys[0]
#           value = val.values[0]
#           p_id = p_id + count
#           hash_loops(user, tree, p_id, key, value, count)
#         end
#       end
#     end
# end
#
#
# def children
#
# end
#
# def parent
#
# end
#
# c = 0
# k1 = coding_sites.keys[0]
# v1 = coding_sites.values[0]

tree2 = Tree.create!(user_id: matt.id, name: "Caching Websites")
Forest.create!(tree_id: tree2.id, project_id: project.id)


# tab = Tab.create!(user_id: matt.id,
#             tree_id: tree2.id,
#             parent_tab_id: nil,
#             url:  k1[1],
#             name: k1[0])
# p_id = tab.id
# hash_loops(matt, tree2, p_id, k1, v1, c)


def user
  User.first
end

def tree
  Tree.find_by(name: "Caching Websites")
end

parse(coding_sites)
