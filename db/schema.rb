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

ActiveRecord::Schema.define(version: 20131006180006) do

  create_table "admins", force: true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "api_authorizations", force: true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "expires_on"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "api_authorizations", ["admin_id"], name: "index_api_authorizations_on_admin_id", using: :btree

  create_table "assignments", force: true do |t|
    t.string   "name"
    t.integer  "value"
    t.datetime "due_date"
    t.integer  "quizlet_id"
    t.integer  "admin_id"
    t.integer  "classroom_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assignments", ["admin_id"], name: "index_assignments_on_admin_id", using: :btree
  add_index "assignments", ["classroom_id"], name: "index_assignments_on_classroom_id", using: :btree

  create_table "classrooms", force: true do |t|
    t.string   "name"
    t.integer  "quizlet_id"
    t.integer  "admin_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classrooms", ["admin_id"], name: "index_classrooms_on_admin_id", using: :btree

  create_table "classrooms_students", force: true do |t|
    t.integer "classroom_id"
    t.integer "student_id"
  end

  create_table "grades", force: true do |t|
    t.string   "mode"
    t.integer  "value"
    t.datetime "finish_date"
    t.integer  "assignment_id"
    t.integer  "student_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "score"
  end

  add_index "grades", ["assignment_id"], name: "index_grades_on_assignment_id", using: :btree
  add_index "grades", ["student_id"], name: "index_grades_on_student_id", using: :btree

  create_table "students", force: true do |t|
    t.string   "username"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
