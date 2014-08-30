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

ActiveRecord::Schema.define(version: 20140830091148) do

  create_table "projects", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["title"], name: "index_projects_on_title", unique: true

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.integer  "project_id"
    t.string   "status"
    t.integer  "priority"
    t.datetime "deadline"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tasks", ["project_id", "created_at", "priority"], name: "index_tasks_on_project_id_and_created_at_and_priority"

end
