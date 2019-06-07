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

ActiveRecord::Schema.define(version: 20190604132201) do

  create_table "accounts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.string "remember_digest"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_accounts_on_email", unique: true
  end

  create_table "check_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "type_text"
    t.boolean "type_boolean"
    t.bigint "user_check_id", null: false
    t.bigint "history_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["history_id"], name: "index_check_histories_on_history_id"
    t.index ["user_check_id", "history_id"], name: "index_check_histories_on_user_check_id_and_history_id", unique: true
    t.index ["user_check_id"], name: "index_check_histories_on_user_check_id"
  end

  create_table "checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.integer "kind", null: false
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", null: false
    t.index ["facility_id"], name: "index_checks_on_facility_id"
  end

  create_table "emergency_contacts", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "relation"
    t.string "email"
    t.string "tel"
    t.integer "pref"
    t.string "city"
    t.string "address"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_emergency_contacts_on_user_id"
  end

  create_table "facilities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "url"
    t.string "image"
    t.string "email"
    t.string "tel"
    t.integer "pref"
    t.string "city"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "account_id"
    t.text "name"
  end

  create_table "histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "day", null: false
    t.text "content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "year"
    t.integer "month"
    t.index ["user_id", "day"], name: "index_histories_on_user_id_and_day", unique: true
    t.index ["user_id"], name: "index_histories_on_user_id"
  end

  create_table "note_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.bigint "facility_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "public", null: false
    t.index ["facility_id"], name: "index_note_categories_on_facility_id"
    t.index ["name", "facility_id"], name: "index_note_categories_on_name_and_facility_id", unique: true
  end

  create_table "notes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "title", null: false
    t.text "content"
    t.string "image"
    t.bigint "user_id", null: false
    t.bigint "note_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["note_category_id"], name: "index_notes_on_note_category_id"
    t.index ["title", "created_at"], name: "index_notes_on_title_and_created_at", unique: true
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "user_checks", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id", null: false
    t.bigint "check_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["check_id"], name: "index_user_checks_on_check_id"
    t.index ["user_id", "check_id"], name: "index_user_checks_on_user_id_and_check_id", unique: true
    t.index ["user_id"], name: "index_user_checks_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name", null: false
    t.string "image"
    t.string "sex", null: false
    t.integer "care_level"
    t.boolean "use_mon", default: false, null: false
    t.boolean "use_tue", default: false, null: false
    t.boolean "use_wed", default: false, null: false
    t.boolean "use_thu", default: false, null: false
    t.boolean "use_fri", default: false, null: false
    t.boolean "use_sat", default: false, null: false
    t.boolean "use_sun", default: false, null: false
    t.bigint "facility_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.index ["facility_id"], name: "index_users_on_facility_id"
    t.index ["name", "created_at"], name: "index_users_on_name_and_created_at", unique: true
  end

  add_foreign_key "check_histories", "histories"
  add_foreign_key "check_histories", "user_checks"
  add_foreign_key "checks", "facilities"
  add_foreign_key "emergency_contacts", "users"
  add_foreign_key "histories", "users"
  add_foreign_key "note_categories", "facilities"
  add_foreign_key "notes", "note_categories"
  add_foreign_key "notes", "users"
  add_foreign_key "user_checks", "checks"
  add_foreign_key "user_checks", "users"
  add_foreign_key "users", "facilities"
end
