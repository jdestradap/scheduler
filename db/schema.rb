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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130201233924) do

  create_table "appointments", :force => true do |t|
    t.integer  "doctor_id"
    t.integer  "patient_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "appointments", ["doctor_id", "start_date"], :name => "index_appointments_on_doctor_id_and_start_date", :unique => true
  add_index "appointments", ["doctor_id"], :name => "index_appointments_on_doctor_id"
  add_index "appointments", ["patient_id", "start_date"], :name => "index_appointments_on_patient_id_and_start_date", :unique => true
  add_index "appointments", ["patient_id"], :name => "index_appointments_on_patient_id"

  create_table "doctors", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "patients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "time_slots", :force => true do |t|
    t.integer "doctor_id"
    t.date    "start_date"
    t.time    "start_time"
    t.time    "end_time"
    t.string  "schedule_rule"
    t.boolean "recurrent",     :default => false
  end

  add_index "time_slots", ["doctor_id", "start_date", "start_date"], :name => "index_time_slots_on_doctor_id_and_start_date_and_start_date", :unique => true
  add_index "time_slots", ["doctor_id"], :name => "index_time_slots_on_doctor_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "role_type"
    t.integer  "role_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
