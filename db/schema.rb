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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20131109201637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: true do |t|
    t.integer  "post_id"
    t.text     "author"
    t.string   "email"
    t.string   "url"
    t.string   "ip"
    t.text     "content"
    t.integer  "karma"
    t.string   "approved"
    t.string   "agent"
    t.string   "comment_type"
    t.integer  "parent"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["post_id"], name: "index_comments_on_post_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "metadata", force: true do |t|
    t.integer  "resource_id"
    t.string   "resource_type"
    t.string   "key"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "metadata", ["resource_id", "resource_type"], name: "index_metadata_on_resource_id_and_resource_type", using: :btree

  create_table "options", force: true do |t|
    t.integer "blog_id"
    t.string  "name"
    t.text    "value"
    t.string  "autoload"
  end

  create_table "posts", force: true do |t|
    t.integer  "users_id"
    t.text     "title"
    t.text     "content"
    t.text     "exerpt"
    t.string   "status"
    t.string   "comment_status"
    t.string   "ping_status"
    t.string   "password_digest"
    t.string   "name"
    t.text     "ping"
    t.text     "pinged"
    t.text     "filter"
    t.integer  "parent"
    t.integer  "menu_order"
    t.string   "type"
    t.string   "mime_type"
    t.integer  "comment_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["users_id"], name: "index_posts_on_users_id", using: :btree

  create_table "posts_term_taxonomies", id: false, force: true do |t|
    t.integer "post_id",          null: false
    t.integer "term_taxonomy_id", null: false
  end

  add_index "posts_term_taxonomies", ["post_id", "term_taxonomy_id"], name: "index_posts_term_taxonomies_on_post_id_and_term_taxonomy_id", using: :btree
  add_index "posts_term_taxonomies", ["term_taxonomy_id", "post_id"], name: "index_posts_term_taxonomies_on_term_taxonomy_id_and_post_id", using: :btree

  create_table "term_taxonomies", force: true do |t|
    t.integer  "term_id"
    t.string   "taxonomy"
    t.text     "description"
    t.integer  "parent"
    t.integer  "count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "term_taxonomies", ["term_id"], name: "index_term_taxonomies_on_term_id", using: :btree

  create_table "terms", force: true do |t|
    t.string   "name"
    t.string   "slug"
    t.integer  "group"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "type"
    t.string   "email"
    t.string   "password_digest"
    t.string   "nicename"
    t.string   "url"
    t.datetime "registered"
    t.string   "activation_key"
    t.integer  "status"
    t.string   "display_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
