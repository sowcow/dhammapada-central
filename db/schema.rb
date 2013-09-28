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

ActiveRecord::Schema.define(version: 20130928124722) do

  create_table "books", force: true do |t|
    t.string   "index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "gathas", force: true do |t|
    t.string   "index"
    t.integer  "vagga_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sources", force: true do |t|
    t.string   "source"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "translations", force: true do |t|
    t.integer  "source_id"
    t.integer  "translateable_id"
    t.string   "translateable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "translations", ["translateable_id", "translateable_type"], name: "index_translations_on_translateable_id_and_translateable_type"

  create_table "vaggas", force: true do |t|
    t.string   "index"
    t.integer  "book_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
