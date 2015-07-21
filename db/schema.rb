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

ActiveRecord::Schema.define(version: 20150721014245) do

  create_table "answers", force: :cascade do |t|
    t.integer "note_id"
    t.integer "subject_id"
    t.integer "user_id"
    t.integer "question_id"
    t.string  "text"
  end

  create_table "meta_tags", force: :cascade do |t|
    t.integer "note_id"
    t.integer "user_id"
    t.string  "subject"
    t.string  "text_qualifier"
    t.integer "number_quantifier"
    t.boolean "boolean_qualifier"
  end

  create_table "notes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
    t.integer  "user_id"
    t.boolean  "public"
    t.integer  "subject_id"
    t.string   "title"
  end

  create_table "questions", force: :cascade do |t|
    t.integer "note_id"
    t.string  "text"
    t.integer "subject_id"
    t.integer "user_id"
    t.integer "answer_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.integer "note_id"
    t.string  "subject"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "firstname"
    t.string   "lastname"
  end

end
