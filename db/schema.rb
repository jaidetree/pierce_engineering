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

ActiveRecord::Schema.define(:version => 20110827200253) do

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "excerpt"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "products"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "data"
  end

  create_table "product_categories", :force => true do |t|
    t.string   "name"
    t.string   "slug"
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cat_type",   :default => 0, :null => false
  end

  create_table "product_images", :force => true do |t|
    t.boolean  "image_selected", :default => false, :null => false
    t.string   "image_caption"
    t.text     "content"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "images"
  end

  create_table "products", :force => true do |t|
    t.string   "name"
    t.text     "excerpt"
    t.text     "content"
    t.text     "prices"
    t.text     "data"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "product_category_id"
    t.string   "slug"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "settings", :force => true do |t|
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "hidden",     :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "hashed_password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "salt"
  end

end
