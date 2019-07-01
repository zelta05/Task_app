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

ActiveRecord::Schema.define(version: 20190701021242) do

  create_table "projects", force: :cascade do |t|
    t.integer "owner_id"
    t.string "name"
    t.string "description"
    t.date "due_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_projects_on_owner_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "project_id"
    t.integer "owner_id"
    t.string "name"
    t.string "description"
    t.date "due_date"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_id"], name: "index_tasks_on_owner_id"
    t.index ["project_id"], name: "index_tasks_on_project_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.integer "collaborator_id"
    t.integer "collaboration_project_id"
    t.integer "permission", default: 0
    t.index ["collaboration_project_id"], name: "index_user_projects_on_collaboration_project_id"
    t.index ["collaborator_id"], name: "index_user_projects_on_collaborator_id"
  end

  create_table "user_tasks", force: :cascade do |t|
    t.integer "assigned_user_id"
    t.integer "assigned_task_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assigned_task_id"], name: "index_user_tasks_on_assigned_task_id"
    t.index ["assigned_user_id"], name: "index_user_tasks_on_assigned_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
