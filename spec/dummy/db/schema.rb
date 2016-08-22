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

ActiveRecord::Schema.define(version: 20160820142403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "addresses", force: :cascade do |t|
    t.string  "address"
    t.string  "zipcode"
    t.string  "city"
    t.string  "phone"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "country_code"
    t.integer "order_id"
    t.index ["order_id"], name: "index_addresses_on_order_id", using: :btree
  end

  create_table "coupons", force: :cascade do |t|
    t.string  "code"
    t.float   "discount"
    t.integer "order_id"
    t.index ["order_id"], name: "index_coupons_on_order_id", using: :btree
  end

  create_table "credit_cards", force: :cascade do |t|
    t.string  "number"
    t.string  "cvv"
    t.integer "year"
    t.integer "month"
    t.string  "firstname"
    t.string  "lastname"
  end

  create_table "deliveries", force: :cascade do |t|
    t.string "title"
    t.float  "price"
  end

  create_table "order_items", force: :cascade do |t|
    t.integer "quantity"
    t.integer "order_id"
    t.index ["order_id"], name: "index_order_items_on_order_id", using: :btree
  end

  create_table "orders", force: :cascade do |t|
    t.float   "total"
    t.string  "state"
    t.uuid    "number",         default: -> { "uuid_generate_v4()" }
    t.integer "credit_card_id"
    t.integer "delivery_id"
    t.integer "user_id"
    t.index ["credit_card_id"], name: "index_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_orders_on_delivery_id", using: :btree
  end

  add_foreign_key "addresses", "orders"
  add_foreign_key "coupons", "orders"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "credit_cards"
  add_foreign_key "orders", "deliveries"
end
