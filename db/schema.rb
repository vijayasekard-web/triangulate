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

ActiveRecord::Schema.define(version: 2018_10_08_003605) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "addresses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "address_1"
    t.string "address_2"
    t.string "city"
    t.string "province"
    t.string "country"
    t.string "postal_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "appointment_histories", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "appointment_id"
    t.string "appointment_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "raw_data"
    t.index ["appointment_id"], name: "index_appointment_histories_on_appointment_id"
  end

  create_table "appointments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "professional_id"
    t.uuid "client_id"
    t.string "appointment_type"
    t.jsonb "metadata"
    t.integer "rating"
    t.decimal "fees"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "profession_type_id"
    t.date "work_date"
    t.integer "status", default: 0, null: false
    t.uuid "matching_schedule_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["profession_type_id"], name: "index_appointments_on_profession_type_id"
    t.index ["professional_id", "client_id"], name: "index_appointments_on_professional_id_and_client_id"
    t.index ["professional_id"], name: "index_appointments_on_professional_id"
  end

  create_table "clients", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "client_type"
    t.string "facility"
    t.string "health_card"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.index ["user_id"], name: "index_clients_on_user_id"
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

  create_table "oauth_access_grants", force: :cascade do |t|
    t.uuid "resource_owner_id", null: false
    t.bigint "application_id", null: false
    t.string "token", null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.datetime "created_at", null: false
    t.datetime "revoked_at"
    t.string "scopes"
    t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
    t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
  end

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.uuid "resource_owner_id"
    t.bigint "application_id"
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
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
    t.boolean "is_active", default: false
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at"
    t.datetime "end_at"
    t.index ["professional_id", "work_date"], name: "index_schedules_on_professional_id_and_work_date"
    t.index ["professional_id"], name: "index_schedules_on_professional_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.date "dob"
    t.string "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "time_zone", default: "UTC", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "appointment_histories", "appointments"
  add_foreign_key "appointments", "clients"
  add_foreign_key "appointments", "profession_types"
  add_foreign_key "appointments", "professionals"
  add_foreign_key "clients", "users"
  add_foreign_key "credit_cards", "clients"
  add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_grants", "users", column: "resource_owner_id"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "oauth_access_tokens", "users", column: "resource_owner_id"
  add_foreign_key "professionals", "profession_types"
  add_foreign_key "professionals", "users"
  add_foreign_key "schedules", "professionals"
end
