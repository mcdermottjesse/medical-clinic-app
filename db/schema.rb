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

ActiveRecord::Schema[7.0].define(version: 2024_04_11_220835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "client_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "client_id"
    t.text "doctor_log"
    t.text "nurse_log"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "log_date"
    t.index ["client_id"], name: "index_client_logs_on_client_id"
    t.index ["user_id"], name: "index_client_logs_on_user_id"
  end

  create_table "client_medications", force: :cascade do |t|
    t.bigint "client_log_id"
    t.string "medication_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_log_id"], name: "index_client_medications_on_client_log_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "client_code"
    t.string "first_name"
    t.string "last_name"
    t.date "dob"
    t.string "pronoun"
    t.string "health_card_number"
    t.date "health_card_expiry"
    t.string "email"
    t.string "phone_number"
    t.string "emergency_contact_name"
    t.string "emergency_contact_info"
    t.string "location"
    t.integer "bed_number"
    t.text "general_info"
    t.boolean "consent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "other_pronoun"
  end

  create_table "medication_names", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.bigint "medication_id"
    t.index ["medication_id"], name: "index_medication_names_on_medication_id"
  end

  create_table "medications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "location"
    t.string "account_type"
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "medication_names", "medications"
end
