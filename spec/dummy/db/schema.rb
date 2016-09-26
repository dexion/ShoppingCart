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

ActiveRecord::Schema.define(version: 20160909150633) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string   "street"
    t.string   "zipcode"
    t.string   "city"
    t.string   "phone"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "country_code"
    t.string   "type"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_id"], name: "index_shopping_cart_addresses_on_order_id", using: :btree
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.string   "code"
    t.float    "discount"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_coupons_on_order_id", using: :btree
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "cvv"
    t.integer  "year"
    t.integer  "month"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_credit_cards_on_order_id", using: :btree
  end

  create_table "shopping_cart_deliveries", force: :cascade do |t|
    t.string   "title"
    t.float    "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.integer  "quantity"
    t.integer  "order_id"
    t.string   "productable_type"
    t.integer  "productable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["order_id"], name: "index_shopping_cart_order_items_on_order_id", using: :btree
    t.index ["productable_type", "productable_id"], name: "productable", using: :btree
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.float    "total"
    t.string   "state"
    t.uuid     "number",         default: -> { "uuid_generate_v4()" }
    t.integer  "delivery_id"
    t.integer  "credit_card_id"
    t.integer  "user_id"
    t.datetime "completed_at"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.index ["credit_card_id"], name: "index_shopping_cart_orders_on_credit_card_id", using: :btree
    t.index ["delivery_id"], name: "index_shopping_cart_orders_on_delivery_id", using: :btree
    t.index ["user_id"], name: "index_shopping_cart_orders_on_user_id", using: :btree
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
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
