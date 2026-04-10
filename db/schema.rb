# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_10_220255) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "file", null: false
    t.bigint "ticket_id", null: false
    t.datetime "updated_at", null: false
    t.index ["ticket_id"], name: "index_attachments_on_ticket_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "floors", null: false
    t.string "identifier", null: false
    t.integer "units_per_floor", null: false
    t.datetime "updated_at", null: false
    t.index ["identifier"], name: "index_blocks_on_identifier", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.datetime "created_at", null: false
    t.bigint "ticket_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["ticket_id"], name: "index_comments_on_ticket_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "ticket_statuses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "is_default", default: false, null: false
    t.boolean "is_final", default: false, null: false
    t.string "name", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_ticket_statuses_on_name", unique: true
  end

  create_table "ticket_types", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "sla_hours", null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.index ["title"], name: "index_ticket_types_on_title", unique: true
  end

  create_table "tickets", force: :cascade do |t|
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.text "description", null: false
    t.datetime "opened_at", null: false
    t.bigint "ticket_status_id", null: false
    t.bigint "ticket_type_id", null: false
    t.bigint "unit_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["ticket_status_id"], name: "index_tickets_on_ticket_status_id"
    t.index ["ticket_type_id"], name: "index_tickets_on_ticket_type_id"
    t.index ["unit_id"], name: "index_tickets_on_unit_id"
    t.index ["user_id"], name: "index_tickets_on_user_id"
  end

  create_table "unit_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.bigint "unit_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["unit_id", "user_id"], name: "index_unit_users_on_unit_id_and_user_id", unique: true
    t.index ["unit_id"], name: "index_unit_users_on_unit_id"
    t.index ["user_id"], name: "index_unit_users_on_user_id"
  end

  create_table "units", force: :cascade do |t|
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.integer "floor", null: false
    t.string "identifier", null: false
    t.integer "number", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_units_on_block_id"
    t.index ["identifier"], name: "index_units_on_identifier", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", null: false
    t.string "name", null: false
    t.string "password_digest", null: false
    t.integer "role", default: 2, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "attachments", "tickets"
  add_foreign_key "comments", "tickets"
  add_foreign_key "comments", "users"
  add_foreign_key "tickets", "ticket_statuses"
  add_foreign_key "tickets", "ticket_types"
  add_foreign_key "tickets", "units"
  add_foreign_key "tickets", "users"
  add_foreign_key "unit_users", "units"
  add_foreign_key "unit_users", "users"
  add_foreign_key "units", "blocks"
end
