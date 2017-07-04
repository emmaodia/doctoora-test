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

ActiveRecord::Schema.define(version: 20170703160416) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consultations", force: :cascade do |t|
    t.string   "discipline"
    t.string   "service"
    t.string   "tool"
    t.date     "date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "professional"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
    t.string   "status"
    t.integer  "doctor_id"
  end

  add_index "consultations", ["doctor_id"], name: "index_consultations_on_doctor_id", using: :btree
  add_index "consultations", ["user_id"], name: "index_consultations_on_user_id", using: :btree

  create_table "conversations", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "recipient_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "dob"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "house"
    t.string   "town"
    t.string   "postcode"
    t.string   "country"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "mdcn_file_name"
    t.string   "mdcn_content_type"
    t.integer  "mdcn_file_size"
    t.datetime "mdcn_updated_at"
    t.string   "nysc_file_name"
    t.string   "nysc_content_type"
    t.integer  "nysc_file_size"
    t.datetime "nysc_updated_at"
    t.string   "uni_cert_file_name"
    t.string   "uni_cert_content_type"
    t.integer  "uni_cert_file_size"
    t.datetime "uni_cert_updated_at"
    t.string   "post_nysc_file_name"
    t.string   "post_nysc_content_type"
    t.integer  "post_nysc_file_size"
    t.datetime "post_nysc_updated_at"
    t.string   "id_proof_file_name"
    t.string   "id_proof_content_type"
    t.integer  "id_proof_file_size"
    t.datetime "id_proof_updated_at"
  end

  add_index "doctors", ["email"], name: "index_doctors_on_email", unique: true, using: :btree
  add_index "doctors", ["reset_password_token"], name: "index_doctors_on_reset_password_token", unique: true, using: :btree

  create_table "messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.boolean  "read"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "patient_records", force: :cascade do |t|
    t.float    "height"
    t.integer  "weight"
    t.float    "bmi"
    t.text     "vaccinations"
    t.text     "conditions"
    t.text     "dietary_restrictions"
    t.text     "alcohol_consumption"
    t.text     "recreatioal_drug_use"
    t.boolean  "tobacco_use"
    t.text     "sexual_activity"
    t.text     "allergies"
    t.text     "medication"
    t.text     "lasting_conditions"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.date     "dob"
  end

  create_table "plans", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "plan_id"
    t.integer  "user_id"
    t.string   "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.date     "dob"
    t.string   "gender"
    t.string   "ethnicity"
    t.string   "house"
    t.string   "town"
    t.string   "postcode"
    t.string   "country"
    t.float    "height"
    t.integer  "weight"
    t.float    "bmi"
    t.text     "vaccinations"
    t.text     "conditions"
    t.string   "dietary_restrictions"
    t.string   "alcohol_consumption"
    t.string   "recreational_drug"
    t.string   "tobacco"
    t.string   "sexual_activity"
    t.integer  "plan_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.text     "allergies"
    t.text     "medication"
    t.text     "lasting_conditions"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "status"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["plan_id"], name: "index_users_on_plan_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "consultations", "doctors"
  add_foreign_key "consultations", "users"
  add_foreign_key "messages", "conversations"
  add_foreign_key "messages", "users"
  add_foreign_key "transactions", "users"
  add_foreign_key "users", "plans"
end
