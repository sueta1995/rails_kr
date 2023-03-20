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

ActiveRecord::Schema[7.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banned_clients", id: :serial, force: :cascade do |t|
    t.text "reason", null: false
    t.integer "client_id", null: false
  end

  create_table "clients", id: :serial, force: :cascade do |t|
    t.string "surname", limit: 23, null: false
    t.string "first_name", limit: 23, null: false
    t.string "patronymic", limit: 23, null: false
    t.string "phone", limit: 11, null: false
    t.string "passport_series", limit: 4, null: false
    t.string "passport_number", limit: 6, null: false
    t.date "birthday", null: false
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "body", null: false
    t.integer "client_id", null: false
    t.integer "speech_therapist_id", null: false
  end

  create_table "contracts", id: :serial, force: :cascade do |t|
    t.integer "hours", null: false
    t.integer "total_cost", null: false
    t.date "issue_date", null: false
    t.integer "client_id", null: false
    t.integer "service_id", null: false
  end

  create_table "rates", id: :serial, force: :cascade do |t|
    t.integer "count", null: false
    t.integer "client_id", null: false
    t.integer "speech_therapist_id", null: false
  end

  create_table "services", id: :serial, force: :cascade do |t|
    t.integer "price_per_hour", null: false
    t.text "description", null: false
    t.integer "speech_therapist_id", null: false
  end

  create_table "speech_therapists", id: :serial, force: :cascade do |t|
    t.integer "client_id", null: false
  end

  add_foreign_key "banned_clients", "clients", name: "banned_clients_client_id_fkey"
  add_foreign_key "comments", "clients", name: "comments_client_id_fkey"
  add_foreign_key "comments", "speech_therapists", name: "comments_speech_therapist_id_fkey"
  add_foreign_key "contracts", "clients", name: "contracts_client_id_fkey"
  add_foreign_key "contracts", "services", name: "contracts_service_id_fkey"
  add_foreign_key "rates", "clients", name: "rates_client_id_fkey"
  add_foreign_key "rates", "speech_therapists", name: "rates_speech_therapist_id_fkey"
  add_foreign_key "services", "speech_therapists", name: "services_speech_therapist_id_fkey"
  add_foreign_key "speech_therapists", "clients", name: "speech_therapists_client_id_fkey"
end
