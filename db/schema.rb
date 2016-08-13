# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160813181655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branches", force: :cascade do |t|
    t.integer  "tree_id"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "parent_branch_id"
    t.index ["tree_id"], name: "index_branches_on_tree_id", using: :btree
    t.index ["user_id"], name: "index_branches_on_user_id", using: :btree
  end

  create_table "tabs", force: :cascade do |t|
    t.integer  "branch_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "parent_tab_id"
    t.string   "nickname"
    t.index ["branch_id"], name: "index_tabs_on_branch_id", using: :btree
    t.index ["user_id"], name: "index_tabs_on_user_id", using: :btree
  end

  create_table "trees", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_trees_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name",       null: false
    t.string   "email",      null: false
    t.string   "password",   null: false
  end

  add_foreign_key "branches", "trees"
  add_foreign_key "branches", "users"
  add_foreign_key "tabs", "branches"
  add_foreign_key "tabs", "users"
  add_foreign_key "trees", "users"
end
