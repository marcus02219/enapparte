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

ActiveRecord::Schema.define(version: 20160127133639) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "postcode"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.integer  "bookings_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "arts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "shows_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "bookings", force: :cascade do |t|
    t.integer  "status"
    t.datetime "date"
    t.integer  "spectators"
    t.float    "price"
    t.text     "message"
    t.float    "payout"
    t.boolean  "payment_received?"
    t.boolean  "payment_sent?"
    t.datetime "paid_on"
    t.datetime "paid_out_on"
    t.integer  "show_id"
    t.integer  "user_id"
    t.integer  "address_id"
    t.integer  "payment_methods_id"
    t.integer  "ratings_id"
    t.integer  "comment_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "title"
    t.integer  "users_id"
    t.integer  "shows_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payment_methods", force: :cascade do |t|
    t.string   "payoption"
    t.string   "provider"
    t.integer  "user_id"
    t.integer  "bookings_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "pictures", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.integer  "imageable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "imageable_type"
  end

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", force: :cascade do |t|
    t.string   "title"
    t.integer  "length"
    t.text     "description"
    t.float    "price"
    t.integer  "max_spectators"
    t.time     "starts_at"
    t.time     "ends_at"
    t.boolean  "active"
    t.integer  "user_id"
    t.integer  "art_id"
    t.integer  "language_id"
    t.integer  "bookings_id"
    t.integer  "pictures_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "firstname"
    t.string   "surname"
    t.integer  "gender"
    t.integer  "sex"
    t.text     "bio"
    t.string   "phone_number"
    t.string   "provider"
    t.integer  "uid"
    t.date     "dob"
    t.string   "activity"
    t.integer  "language_id"
    t.integer  "addresses_id"
    t.integer  "bookings_id"
    t.integer  "payment_methods_id"
    t.integer  "shows_id"
    t.integer  "picture_id"
    t.float    "rating"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
