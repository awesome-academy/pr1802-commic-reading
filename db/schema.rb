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

ActiveRecord::Schema.define(version: 20180831024116) do

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chapters", force: :cascade do |t|
    t.string "title"
    t.integer "comic_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_chapters_on_comic_id"
    t.index ["user_id"], name: "index_chapters_on_user_id"
  end

  create_table "comic_categories", force: :cascade do |t|
    t.integer "category_id"
    t.integer "comic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_comic_categories_on_category_id"
    t.index ["comic_id"], name: "index_comic_categories_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.integer "author_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.string "average_ratings"
    t.index ["author_id"], name: "index_comics_on_author_id"
    t.index ["user_id", "created_at"], name: "index_comics_on_user_id_and_created_at"
    t.index ["user_id"], name: "index_comics_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.integer "chapter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chapter_id"], name: "index_comments_on_chapter_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "user_id"
    t.integer "comic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_follows_on_comic_id"
    t.index ["user_id", "comic_id"], name: "index_follows_on_user_id_and_comic_id", unique: true
    t.index ["user_id"], name: "index_follows_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "rate"
    t.integer "user_id"
    t.integer "comic_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comic_id"], name: "index_rates_on_comic_id"
    t.index ["user_id", "comic_id"], name: "index_rates_on_user_id_and_comic_id", unique: true
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.string "keywords"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
  end

end
