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

ActiveRecord::Schema.define(version: 20160411073755) do

  create_table "addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "postcode"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "user_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "is_primary", default: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id"

  create_table "arts", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
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
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "payment_method_id"
  end

  add_index "bookings", ["address_id"], name: "index_bookings_on_address_id"
  add_index "bookings", ["payment_method_id"], name: "index_bookings_on_payment_method_id"
  add_index "bookings", ["show_id"], name: "index_bookings_on_show_id"
  add_index "bookings", ["user_id"], name: "index_bookings_on_user_id"

  create_table "languages", force: :cascade do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "languages", ["user_id"], name: "index_languages_on_user_id"

  create_table "payment_methods", force: :cascade do |t|
    t.integer "user_id"
    t.integer "booking_id"
    t.string  "stripe_token"
    t.string  "last4"
  end

  add_index "payment_methods", ["booking_id"], name: "index_payment_methods_on_booking_id"
  add_index "payment_methods", ["user_id"], name: "index_payment_methods_on_user_id"

  create_table "pictures", force: :cascade do |t|
    t.string   "title"
    t.boolean  "selected"
    t.string   "imageable_type"
    t.integer  "imageable_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "value"
    t.integer  "review_id"
    t.integer  "user_id"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "ratings", ["booking_id"], name: "index_ratings_on_booking_id"
  add_index "ratings", ["review_id"], name: "index_ratings_on_review_id"
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id"

  create_table "reviews", force: :cascade do |t|
    t.text     "review"
    t.integer  "booking_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "reviews", ["booking_id"], name: "index_reviews_on_booking_id"

  create_table "shows", force: :cascade do |t|
    t.string   "title"
    t.integer  "length"
    t.integer  "surface"
    t.text     "description"
    t.float    "price"
    t.integer  "max_spectators"
    t.string   "starts_at"
    t.string   "ends_at"
    t.boolean  "active"
    t.datetime "published_at"
    t.integer  "cover_picture_id"
    t.integer  "user_id"
    t.integer  "art_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "rating"
  end

  add_index "shows", ["art_id"], name: "index_shows_on_art_id"
  add_index "shows", ["cover_picture_id"], name: "index_shows_on_cover_picture_id"
  add_index "shows", ["user_id"], name: "index_shows_on_user_id"

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
    t.integer  "role",                   default: 1
    t.string   "firstname"
    t.string   "surname"
    t.integer  "gender"
    t.text     "bio"
    t.string   "phone_number"
    t.date     "dob"
    t.string   "activity"
    t.boolean  "moving"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
