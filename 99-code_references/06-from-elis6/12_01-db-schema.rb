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

ActiveRecord::Schema.define(version: 20171224125745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.text     "full_address"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "address_tag"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "favorite_id"
    t.string   "title"
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.integer  "status"
    t.string   "taxation_number_first"
    t.string   "taxation_number_second"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "favorite_id"
    t.string   "building"
    t.string   "full_address"
    t.string   "address_tag"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "web_site"
    t.text     "note_contacts"
  end

  create_table "company_person_map_translations", force: :cascade do |t|
    t.integer  "company_person_map_id", null: false
    t.string   "locale",                null: false
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "summary"
    t.string   "building"
    t.string   "job_title"
    t.index ["company_person_map_id"], name: "index_company_person_map_translations_on_company_person_map_id", using: :btree
    t.index ["locale"], name: "index_company_person_map_translations_on_locale", using: :btree
  end

  create_table "company_person_maps", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "person_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "favorite_id_company"
    t.integer  "favorite_id_person"
    t.string   "full_address"
    t.string   "address_tag"
    t.decimal  "latitude"
    t.decimal  "longitude"
    t.string   "job_title_useful"
    t.string   "mobile"
    t.string   "phone"
    t.string   "direct"
    t.string   "fax"
    t.string   "email"
    t.text     "note"
    t.index ["company_id"], name: "index_company_person_maps_on_company_id", using: :btree
    t.index ["person_id"], name: "index_company_person_maps_on_person_id", using: :btree
  end

  create_table "company_translations", force: :cascade do |t|
    t.integer  "company_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "sector"
    t.text     "memo"
    t.index ["company_id"], name: "index_company_translations_on_company_id", using: :btree
    t.index ["locale"], name: "index_company_translations_on_locale", using: :btree
  end

  create_table "component_translations", force: :cascade do |t|
    t.integer  "component_id", null: false
    t.string   "locale",       null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "name"
    t.text     "description"
    t.index ["component_id"], name: "index_component_translations_on_component_id", using: :btree
    t.index ["locale"], name: "index_component_translations_on_locale", using: :btree
  end

  create_table "components", force: :cascade do |t|
    t.string   "part_number"
    t.integer  "supplier_id"
    t.string   "homonym"
    t.text     "memo"
    t.decimal  "supplier_price_list",         default: "0.0"
    t.string   "currency",                    default: "EUR"
    t.decimal  "currency_exchange",           default: "1.0"
    t.integer  "currency_rounding"
    t.decimal  "discount_one_percentage",     default: "0.0"
    t.integer  "discount_rounding"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.decimal  "discount_one_min_quantity",   default: "1.0"
    t.integer  "discount_one_rounding"
    t.decimal  "discount_two_min_quantity"
    t.decimal  "discount_two_percentage"
    t.integer  "discount_two_rounding"
    t.decimal  "discount_three_min_quantity"
    t.decimal  "discount_three_percentage"
    t.integer  "discount_three_rounding"
    t.decimal  "discount_four_min_quantity"
    t.decimal  "discount_four_percentage"
    t.integer  "discount_four_rounding"
    t.decimal  "discount_five_min_quantity"
    t.decimal  "discount_five_percentage"
    t.integer  "discount_five_rounding"
    t.text     "discount_note"
    t.integer  "factory_id"
  end

  create_table "contact_translations", force: :cascade do |t|
    t.integer  "contact_id", null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "medium"
    t.index ["contact_id"], name: "index_contact_translations_on_contact_id", using: :btree
    t.index ["locale"], name: "index_contact_translations_on_locale", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.integer  "contactable_id"
    t.string   "contactable_type"
    t.string   "identifier"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "favorite_id"
  end

  create_table "dossiers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cord_number"
    t.date     "delivery_date"
    t.integer  "delivery_date_alarm"
    t.integer  "final_total_quantity"
    t.integer  "final_quantity_alarm"
    t.decimal  "final_price"
    t.integer  "final_price_alarm"
    t.date     "payment_date"
    t.integer  "payment_alarm"
    t.integer  "documental_flow_alarm"
    t.integer  "dossier_alarm"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "dossier_number"
  end

  create_table "favorite_translations", force: :cascade do |t|
    t.integer  "favorite_id", null: false
    t.string   "locale",      null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "copy_normal"
    t.string   "copy_bold"
    t.index ["favorite_id"], name: "index_favorite_translations_on_favorite_id", using: :btree
    t.index ["locale"], name: "index_favorite_translations_on_locale", using: :btree
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "favoritable_id"
    t.string   "favoritable_type"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "copy_table_id"
    t.string   "copy_table"
    t.index ["favoritable_id", "favoritable_type"], name: "index_favorites_on_favoritable_id_and_favoritable_type", using: :btree
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "historyable_id"
    t.string   "historyable_type"
    t.string   "title"
    t.datetime "manual_date"
    t.text     "memo"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "favorite_id"
  end

  create_table "person_translations", force: :cascade do |t|
    t.integer  "person_id",  null: false
    t.string   "locale",     null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
    t.string   "homonym"
    t.text     "memo"
    t.index ["locale"], name: "index_person_translations_on_locale", using: :btree
    t.index ["person_id"], name: "index_person_translations_on_person_id", using: :btree
  end

  create_table "select_related_translations", force: :cascade do |t|
    t.integer  "select_related_id", null: false
    t.string   "locale",            null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "name"
    t.index ["locale"], name: "index_select_related_translations_on_locale", using: :btree
    t.index ["select_related_id"], name: "index_select_related_translations_on_select_related_id", using: :btree
  end

  create_table "select_relateds", force: :cascade do |t|
    t.string   "metadata"
    t.boolean  "bln_homepage"
    t.boolean  "bln_people"
    t.boolean  "bln_companies"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "bln_components"
    t.boolean  "bln_dossiers"
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
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "company_person_maps", "companies"
  add_foreign_key "company_person_maps", "people"
  add_foreign_key "components", "companies", column: "factory_id"
end
