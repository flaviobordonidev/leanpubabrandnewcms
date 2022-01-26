# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_16_103657) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "eg_companies", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "part_number"
  end

  create_table "eg_components", force: :cascade do |t|
    t.string "name"
    t.bigint "eg_company_id", null: false
    t.text "description"
    t.integer "shelf_life"
    t.integer "service_life"
    t.datetime "supplier_price_list_expiration_date"
    t.decimal "supplier_price_list"
    t.string "currency"
    t.decimal "currency_exchange"
    t.integer "currency_rounding"
    t.decimal "supplier_discount"
    t.integer "discount_rounding"
    t.string "country_of_origin"
    t.string "custom_tariff_number"
    t.decimal "net_weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "part_number"
    t.index ["eg_company_id"], name: "index_eg_components_on_eg_company_id"
  end

  create_table "eg_posts", force: :cascade do |t|
    t.string "meta_title"
    t.string "meta_description"
    t.string "headline"
    t.string "incipit"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 19, scale: 4, default: "0.0"
    t.index ["user_id"], name: "index_eg_posts_on_user_id"
  end

  create_table "eg_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "eg_components", "eg_companies"
  add_foreign_key "eg_posts", "users"
end
