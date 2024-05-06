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

ActiveRecord::Schema.define(version: 2024_05_04_172527) do

  create_table "doctors", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "specialization"
    t.string "phone_number"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "medications", id: :string, force: :cascade do |t|
    t.string "name"
    t.integer "serial_id"
    t.string "description"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "patients", id: :string, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "country_code"
    t.integer "age"
    t.string "phone_number"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "prescriptions", id: :string, force: :cascade do |t|
    t.string "patient_id"
    t.string "doctor_id"
    t.string "medication_id"
    t.string "dosage"
    t.string "frequency"
    t.text "days", default: "[]"
    t.text "time_per_day", default: "[]"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "reminders", id: :string, force: :cascade do |t|
    t.string "prescription_id"
    t.datetime "reminder_time"
    t.boolean "is_scheduled"
    t.boolean "is_sent"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
