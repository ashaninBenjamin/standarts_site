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

ActiveRecord::Schema.define(:version => 20130126204048) do

  create_table "blocks", :force => true do |t|
    t.integer "number"
    t.text    "name"
    t.text    "content"
    t.text    "is_show"
    t.integer "user_id"
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "helps", :force => true do |t|
    t.string  "name"
    t.text    "content"
    t.integer "number"
  end

  create_table "points", :force => true do |t|
    t.integer "parent_id"
    t.integer "block_id"
    t.string  "name"
    t.string  "code"
    t.text    "content"
  end

  create_table "roles", :force => true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "standards", :force => true do |t|
    t.integer "number"
    t.string  "name"
    t.text    "content"
    t.integer "parent_id"
    t.integer "user_id"
    t.string  "show_number"
    t.string  "turn_on"
  end

  create_table "user_infos", :force => true do |t|
    t.string "surname"
    t.string "name"
    t.string "patronymic"
    t.string "mail"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.integer  "user_info_id"
    t.integer  "roles_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "salt"
    t.string   "en_password"
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
