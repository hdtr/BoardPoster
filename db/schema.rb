# encoding: UTF-8
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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130319123710) do

  create_table "branches", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "tree_id",    :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "comments", :id => false, :force => true do |t|
  end

  create_table "forests", :force => true do |t|
    t.string   "name"
    t.string   "meta_title"
    t.string   "meta_keyword"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "forests_lakes", :id => false, :force => true do |t|
    t.integer "forest_id", :null => false
    t.integer "lake_id",   :null => false
  end

  create_table "lakes", :force => true do |t|
    t.string   "title",      :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "payloads", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.string   "address"
    t.datetime "date"
    t.string   "title"
    t.string   "message"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "rocks", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "forest_id",  :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roots", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "tree_id",    :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "trees", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "forest_id",  :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "trunks", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "tree_id",    :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "token"
    t.string   "email"
    t.boolean  "confirmed",         :default => false
    t.string   "confirmation_code"
  end

  add_index "users", ["token"], :name => "index_users_on_token"

end
