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

ActiveRecord::Schema.define(version: 20140921072114) do

  create_table "admin_users", force: true do |t|
  end

  create_table "admins", force: true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.string  "text"
    t.integer "question_id"
    t.boolean "correct"
  end

  create_table "courses", force: true do |t|
    t.string   "title"
    t.text     "intro"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", force: true do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "position"
    t.integer  "duration_days"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.text     "text"
    t.integer  "lesson_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", force: true do |t|
    t.integer  "user_id"
    t.integer  "lesson_id"
    t.integer  "grade"
    t.string   "secret"
    t.datetime "expire"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.integer  "gender"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "birthday"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
