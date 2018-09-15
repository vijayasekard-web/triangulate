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

ActiveRecord::Schema.define(version: 2018_09_12_111156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "appointments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "professional_id"
    t.uuid "client_id"
    t.string "appointment_type"
    t.boolean "client_status"
    t.boolean "professional_status"
    t.jsonb "metadata"
    t.integer "rating"
    t.decimal "fees"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["professional_id", "client_id"], name: "index_appointments_on_professional_id_and_client_id", unique: true
    t.index ["professional_id"], name: "index_appointments_on_professional_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "client_type"
    t.string "facility"
    t.string "health_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_cards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "client_id"
    t.string "name_on_card"
    t.string "card_type"
    t.string "card_number"
    t.date "expiry"
    t.integer "ccv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_credit_cards_on_client_id"
  end

  create_table "profession_types", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.boolean "license_required"
    t.string "state"
    t.string "country"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "professional_clients", force: :cascade do |t|
    t.uuid "professional_id"
    t.uuid "client_id"
    t.datetime "first_visit"
    t.datetime "last_visit"
    t.integer "total_visits"
    t.integer "cancelled_visits"
    t.boolean "is_blocked_by_client"
    t.boolean "is_blocked_by_pro"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_professional_clients_on_client_id"
    t.index ["professional_id", "client_id"], name: "index_professional_clients_on_professional_id_and_client_id", unique: true
    t.index ["professional_id"], name: "index_professional_clients_on_professional_id"
  end

  create_table "professionals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "profession_type_id"
    t.uuid "user_id"
    t.string "license_id"
    t.boolean "is_licensed"
    t.boolean "is_active"
    t.string "postal_code"
    t.integer "radius"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profession_type_id"], name: "index_professionals_on_profession_type_id"
    t.index ["user_id"], name: "index_professionals_on_user_id"
  end

  create_table "schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "professional_id"
    t.date "work_date"
    t.jsonb "time_slots"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["professional_id", "work_date"], name: "index_schedules_on_professional_id_and_work_date", unique: true
    t.index ["professional_id"], name: "index_schedules_on_professional_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.date "dob"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "appointments", "clients"
  add_foreign_key "appointments", "professionals"
  add_foreign_key "credit_cards", "clients"
  add_foreign_key "professionals", "profession_types"
  add_foreign_key "professionals", "users"
  add_foreign_key "schedules", "professionals"
end
