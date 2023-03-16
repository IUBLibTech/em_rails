# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_01_25_183421) do

  create_table "annotations", charset: "utf8mb3", force: :cascade do |t|
    t.integer "book_id"
    t.text "title"
    t.text "description", size: :medium
    t.string "page_reference"
    t.string "media_type"
    t.boolean "sample"
    t.boolean "avalon_segment"
    t.string "avalon_purl"
    t.bigint "image_id"
    t.bigint "thumb_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "media_file_id"
  end

  create_table "books", charset: "utf8mb3", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.text "description", size: :medium
    t.string "published_date"
    t.integer "pages"
    t.string "buy_url"
    t.text "summary", size: :medium
    t.string "oclc"
    t.text "table_of_contents", size: :medium
    t.text "bio_text", size: :medium
    t.boolean "featured"
    t.integer "image_id"
    t.string "press"
    t.text "subtitle"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "image_file", id: :bigint, default: nil, charset: "latin1", options: "ENGINE=MyISAM", force: :cascade do |t|
    t.binary "image_bytes", size: :long
    t.integer "width"
    t.integer "height"
    t.binary "thumb_bytes", size: :long
    t.index ["id"], name: "FKA9FAA5E096D3B389"
    t.index ["id"], name: "FKA9FAA5E0D2B3110D"
  end

  create_table "images", charset: "utf8mb3", force: :cascade do |t|
    t.binary "image_bytes", size: :medium
    t.integer "width"
    t.integer "height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_books", charset: "utf8mb3", force: :cascade do |t|
    t.integer "user_id"
    t.integer "book_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "old_password_sha1"
    t.string "old_password_confirmation"
    t.boolean "password_converted", default: false
    t.string "password_hash"
    t.string "password_confirmation"
    t.string "password_reset_key"
    t.datetime "password_reset_key_timestamp"
    t.string "account_activation_key"
    t.boolean "account_activated"
    t.boolean "agreed_to_eula"
    t.boolean "author_user", default: false
    t.boolean "reviewer_user", default: false
    t.boolean "editor_user", default: false
    t.boolean "publisher_user", default: false
    t.boolean "admin_user", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_salt"
  end

end
