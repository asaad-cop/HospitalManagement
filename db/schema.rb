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

ActiveRecord::Schema.define(version: 2022_08_02_135121) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hospital_treatments", force: :cascade do |t|
    t.integer "price"
    t.bigint "hospital_id"
    t.bigint "treatment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_hospital_treatments_on_hospital_id"
    t.index ["treatment_id"], name: "index_hospital_treatments_on_treatment_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "name"
    t.string "city"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requests", force: :cascade do |t|
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "patient_id"
    t.index ["patient_id"], name: "index_requests_on_patient_id"
    t.index ["user_id"], name: "index_requests_on_user_id"
  end

  create_table "treatments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.bigint "hospital_id"
    t.bigint "treatment_id"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["hospital_id"], name: "index_users_on_hospital_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["treatment_id"], name: "index_users_on_treatment_id"
  end

  add_foreign_key "hospital_treatments", "hospitals"
  add_foreign_key "hospital_treatments", "treatments"
  add_foreign_key "requests", "users"
  add_foreign_key "requests", "users", column: "patient_id"
  add_foreign_key "users", "hospitals"
  add_foreign_key "users", "treatments"
end
