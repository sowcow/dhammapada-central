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

ActiveRecord::Schema.define(version: 20131001153738) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
