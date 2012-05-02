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

ActiveRecord::Schema.define(:version => 20120502140402) do

  create_table "away_calendars", :force => true do |t|
    t.integer  "phone_number_setup_id"
    t.datetime "start_at"
    t.datetime "end_at"
    t.string   "message"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "messages", :force => true do |t|
    t.datetime "received"
    t.string   "destination"
    t.string   "origin"
    t.string   "direction"
    t.string   "message_type"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.datetime "replied_on"
    t.integer  "reply_message_id"
    t.integer  "user_id"
    t.integer  "phone_number_setup_id"
    t.string   "reply_text"
    t.string   "message_id"
  end

  add_index "messages", ["destination", "origin", "received"], :name => "index_messages_on_destination_and_origin_and_received", :unique => true

  create_table "phone_number_setups", :force => true do |t|
    t.integer  "user_id"
    t.string   "username"
    t.string   "password"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "provider_id"
    t.string   "phone"
  end

  create_table "providers", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
