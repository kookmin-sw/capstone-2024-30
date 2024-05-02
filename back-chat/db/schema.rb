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

ActiveRecord::Schema.define(version: 2024_04_27_133843) do

  create_table "announcement_files", primary_key: "announcement_file_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "link"
    t.string "title"
    t.bigint "announcement_id"
    t.index ["announcement_id"], name: "FK70ifj0ccp393fv5ysusilffcm"
  end

  create_table "announcements", primary_key: "announcement_id", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_date", precision: 6
    t.datetime "modified_date", precision: 6
    t.string "author"
    t.string "author_phone"
    t.string "department"
    t.text "document", size: :long, null: false
    t.string "language", null: false
    t.string "title", null: false
    t.string "type", null: false
    t.string "url", null: false
    t.date "written_date", null: false
  end

  create_table "chat_rooms", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "user1_uuid", null: false
    t.string "user2_uuid", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user1_uuid", "user2_uuid"], name: "index_chat_rooms_on_user1_uuid_and_user2_uuid", unique: true
  end

  create_table "menu", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "cafeteria", null: false
    t.datetime "date", precision: 6, null: false
    t.string "language", null: false
    t.string "name", null: false
    t.bigint "price", null: false
    t.string "section", null: false
  end

  create_table "users", primary_key: "user_id", id: :string, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.datetime "created_date", precision: 6
    t.datetime "modified_date", precision: 6
    t.string "country", null: false
    t.string "email", null: false
    t.string "major", null: false
    t.string "name", null: false
    t.string "phone_number"
    t.string "role"
    t.index ["email"], name: "UK_6dotkott2kjsp8vw4d0m25fb7", unique: true
  end

  add_foreign_key "announcement_files", "announcements", primary_key: "announcement_id", name: "FK70ifj0ccp393fv5ysusilffcm"
end
