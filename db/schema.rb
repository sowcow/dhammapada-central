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

ActiveRecord::Schema.define(version: 20131010084425) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "articles", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "translateable_id"
    t.string   "translateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "articles", ["translateable_id", "translateable_type"], name: "index_articles_on_translateable_id_and_translateable_type", using: :btree

  create_table "books", force: true do |t|
    t.string   "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "books", ["index"], name: "index_books_on_index", using: :btree

  create_table "excerpt_links", force: true do |t|
    t.integer  "one_id"
    t.integer  "two_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "excerpts", force: true do |t|
    t.integer  "phrase_id"
    t.integer  "translation_id"
    t.integer  "from"
    t.integer  "to"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "meaning_id"
  end

  create_table "gathas", force: true do |t|
    t.string   "index"
    t.integer  "vagga_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gathas", ["index"], name: "index_gathas_on_index", using: :btree

  create_table "languages", force: true do |t|
    t.string   "index"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meanings", force: true do |t|
    t.integer  "translateable_id"
    t.string   "translateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "meanings", ["translateable_id", "translateable_type"], name: "index_meanings_on_translateable_id_and_translateable_type", using: :btree

  create_table "phrases", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "lang"
  end

  create_table "translations", force: true do |t|
    t.integer  "source_id"
    t.integer  "translateable_id"
    t.string   "translateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "text"
  end

  add_index "translations", ["translateable_id", "translateable_type"], name: "index_translations_on_translateable_id_and_translateable_type", using: :btree

  create_table "vaggas", force: true do |t|
    t.string   "index"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vaggas", ["index"], name: "index_vaggas_on_index", using: :btree

end
