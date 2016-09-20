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

ActiveRecord::Schema.define(version: 20160920215808) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "archives", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_archives_on_user_id", using: :btree
  end

  create_table "forests", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "tree_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_forests_on_project_id", using: :btree
    t.index ["tree_id"], name: "index_forests_on_tree_id", using: :btree
  end

  create_table "members", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_members_on_project_id", using: :btree
    t.index ["user_id"], name: "index_members_on_user_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_projects_on_user_id", using: :btree
  end

  create_table "tabs", force: :cascade do |t|
    t.integer  "tree_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "parent_tab_id"
    t.string   "name"
    t.text     "url"
    t.index ["tree_id"], name: "index_tabs_on_tree_id", using: :btree
    t.index ["user_id"], name: "index_tabs_on_user_id", using: :btree
  end

  create_table "trees", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
    t.boolean  "archived"
    t.index ["user_id"], name: "index_trees_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "name",                           null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

  add_foreign_key "archives", "users"
  add_foreign_key "forests", "projects"
  add_foreign_key "forests", "trees"
  add_foreign_key "members", "projects"
  add_foreign_key "members", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "tabs", "trees"
  add_foreign_key "tabs", "users"
  add_foreign_key "trees", "users"
end
