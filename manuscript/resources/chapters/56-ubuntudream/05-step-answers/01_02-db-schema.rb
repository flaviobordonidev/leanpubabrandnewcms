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

ActiveRecord::Schema.define(version: 2021_12_10_154035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

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
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.string "value"
    t.bigint "step_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["step_id"], name: "index_answers_on_step_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "building"
    t.string "address"
    t.integer "client_type", default: 0
    t.integer "client_rate"
    t.integer "supplier_type", default: 0
    t.integer "supplier_rate"
    t.string "tax_number_1"
    t.string "tax_number_2"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_type"], name: "index_companies_on_client_type"
    t.index ["supplier_type"], name: "index_companies_on_supplier_type"
  end

  create_table "company_person_map_translations", force: :cascade do |t|
    t.bigint "company_person_map_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "summary"
    t.index ["company_person_map_id"], name: "index_company_person_map_translations_on_company_person_map_id"
    t.index ["locale"], name: "index_company_person_map_translations_on_locale"
  end

  create_table "company_person_maps", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "person_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_company_person_maps_on_company_id"
    t.index ["person_id"], name: "index_company_person_maps_on_person_id"
  end

  create_table "company_translations", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "note"
    t.string "sector"
    t.index ["company_id"], name: "index_company_translations_on_company_id"
    t.index ["locale"], name: "index_company_translations_on_locale"
  end

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

  create_table "eg_post_translations", force: :cascade do |t|
    t.bigint "eg_post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "meta_title"
    t.string "meta_description"
    t.string "headline"
    t.string "incipit"
    t.text "description"
    t.index ["eg_post_id"], name: "index_eg_post_translations_on_eg_post_id"
    t.index ["locale"], name: "index_eg_post_translations_on_locale"
  end

  create_table "eg_posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "price", precision: 19, scale: 4, default: "0.0"
    t.boolean "published", default: false
    t.datetime "published_at"
    t.index ["user_id"], name: "index_eg_posts_on_user_id"
  end

  create_table "eg_users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "emails", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "emailable_id"
    t.string "emailable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "homonym"
    t.text "note"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "person_translations", force: :cascade do |t|
    t.bigint "person_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.index ["locale"], name: "index_person_translations_on_locale"
    t.index ["person_id"], name: "index_person_translations_on_person_id"
  end

  create_table "socials", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "socialable_id"
    t.string "socialable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "steps", force: :cascade do |t|
    t.string "question"
    t.text "answer"
    t.bigint "lesson_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_steps_on_lesson_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.bigint "todo_list_id", null: false
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["todo_list_id"], name: "index_tasks_on_todo_list_id"
  end

  create_table "telephones", force: :cascade do |t|
    t.string "name"
    t.string "prefix"
    t.string "number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "telephoneable_id"
    t.string "telephoneable_type"
  end

  create_table "todo_lists", force: :cascade do |t|
    t.string "name"
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
    t.text "biography"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "steps"
  add_foreign_key "company_person_maps", "companies"
  add_foreign_key "company_person_maps", "people"
  add_foreign_key "eg_components", "eg_companies"
  add_foreign_key "eg_posts", "users"
  add_foreign_key "steps", "lessons"
  add_foreign_key "tasks", "todo_lists"
end
