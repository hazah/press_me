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

ActiveRecord::Schema.define(version: 20131114034945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blogs", force: true do |t|
    t.integer  "site_id",                    null: false
    t.string   "domain",                     null: false
    t.string   "path",                       null: false
    t.boolean  "public",     default: true,  null: false
    t.boolean  "archived",   default: false, null: false
    t.boolean  "mature",     default: false, null: false
    t.boolean  "span",       default: false, null: false
    t.boolean  "deleted",    default: false, null: false
    t.integer  "lang_id",    default: 0,     null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "blogs", ["domain", "path"], name: "index_blogs_on_domain_and_path", using: :btree
  add_index "blogs", ["site_id"], name: "index_blogs_on_site_id", using: :btree

  create_table "comments", force: true do |t|
    t.integer  "post_id",                    null: false
    t.text     "author_name"
    t.string   "author_email"
    t.string   "author_url"
    t.string   "author_ip"
    t.text     "content",                    null: false
    t.integer  "karma",        default: 0,   null: false
    t.string   "approved",     default: "1", null: false
    t.string   "agent",                      null: false
    t.string   "comment_type",               null: false
    t.integer  "parent_id"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "comments", ["approved", "created_at"], name: "index_comments_on_approved_and_created_at", using: :btree
  add_index "comments", ["parent_id"], name: "index_comments_on_parent_id", using: :btree
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
    t.integer "resource_id",   null: false
    t.string  "resource_type", null: false
    t.string  "name",          null: false
    t.text    "value",         null: false
  end

  add_index "metadata", ["resource_id", "resource_type"], name: "index_metadata_on_resource_id_and_resource_type", using: :btree

  create_table "options", force: true do |t|
    t.integer "blog_id",                  null: false
    t.string  "name",                     null: false
    t.text    "value",                    null: false
    t.string  "autoload", default: "yes", null: false
  end

  add_index "options", ["blog_id"], name: "index_options_on_blog_id", using: :btree

  create_table "posts", force: true do |t|
    t.integer  "blog_id",                             null: false
    t.integer  "user_id",                             null: false
    t.text     "title",                               null: false
    t.text     "content",                             null: false
    t.text     "exerpt",                              null: false
    t.string   "status",          default: "publish", null: false
    t.string   "comment_status",  default: "open",    null: false
    t.string   "ping_status",     default: "open",    null: false
    t.string   "password_digest",                     null: false
    t.string   "name",                                null: false
    t.text     "ping",                                null: false
    t.text     "pinged",                              null: false
    t.text     "filtered",                            null: false
    t.integer  "parent",                              null: false
    t.integer  "menu_order",                          null: false
    t.string   "post_type",                           null: false
    t.string   "mime_type",                           null: false
    t.integer  "comment_count",                       null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "posts", ["blog_id"], name: "index_posts_on_blog_id", using: :btree
  add_index "posts", ["post_type", "status", "created_at", "id"], name: "index_posts_on_post_type_and_status_and_created_at_and_id", using: :btree
  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "posts_term_taxonomies", id: false, force: true do |t|
    t.integer "post_id",                      null: false
    t.integer "term_taxonomy_id",             null: false
    t.integer "term_order",       default: 0, null: false
  end

  add_index "posts_term_taxonomies", ["post_id", "term_taxonomy_id"], name: "index_posts_term_taxonomies_on_post_id_and_term_taxonomy_id", using: :btree
  add_index "posts_term_taxonomies", ["term_taxonomy_id", "post_id"], name: "index_posts_term_taxonomies_on_term_taxonomy_id_and_post_id", using: :btree

  create_table "registration_logs", force: true do |t|
    t.string   "email",      null: false
    t.string   "ip",         null: false
    t.integer  "blog_id",    null: false
    t.datetime "registered", null: false
  end

  add_index "registration_logs", ["blog_id"], name: "index_registration_logs_on_blog_id", using: :btree

  create_table "signups", force: true do |t|
    t.string   "domain",                         null: false
    t.string   "path",                           null: false
    t.text     "title",                          null: false
    t.string   "email",                          null: false
    t.datetime "activated",                      null: false
    t.boolean  "active",         default: false, null: false
    t.string   "activation_key",                 null: false
    t.text     "meta"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "signups", ["domain", "path"], name: "index_signups_on_domain_and_path", using: :btree

  create_table "sites", force: true do |t|
    t.string   "domain",     null: false
    t.string   "path",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sites", ["domain", "path"], name: "index_sites_on_domain_and_path", using: :btree

  create_table "term_taxonomies", force: true do |t|
    t.integer  "term_id",                 null: false
    t.string   "taxonomy",                null: false
    t.text     "description",             null: false
    t.integer  "parent_id"
    t.integer  "count",       default: 0, null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "term_taxonomies", ["term_id", "taxonomy"], name: "index_term_taxonomies_on_term_id_and_taxonomy", using: :btree
  add_index "term_taxonomies", ["term_id"], name: "index_term_taxonomies_on_term_id", using: :btree

  create_table "terms", force: true do |t|
    t.integer  "blog_id",                null: false
    t.string   "name",                   null: false
    t.string   "slug",                   null: false
    t.integer  "group",      default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "terms", ["blog_id"], name: "index_terms_on_blog_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "type",                            null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "nicename",        default: "",    null: false
    t.string   "url",             default: "",    null: false
    t.string   "activation_key",  default: "",    null: false
    t.integer  "status",          default: 0,     null: false
    t.string   "display_name",    default: "",    null: false
    t.boolean  "spam",            default: false, null: false
    t.boolean  "deleted",         default: false, null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

end
