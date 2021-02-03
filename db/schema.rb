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

ActiveRecord::Schema.define(version: 2021_02_03_022506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friends", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "friend_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friend_id"], name: "index_friends_on_friend_id"
    t.index ["user_id"], name: "index_friends_on_user_id"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "run_time"
    t.string "genre"
  end

  create_table "parties", force: :cascade do |t|
    t.bigint "movie_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["movie_id"], name: "index_parties_on_movie_id"
  end

  create_table "parties_users", id: false, force: :cascade do |t|
    t.bigint "party_id", null: false
    t.bigint "user_id", null: false
    t.boolean "host"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.boolean "is_registered?", default: false
  end

  add_foreign_key "friends", "users"
  add_foreign_key "friends", "users", column: "friend_id"
  add_foreign_key "parties", "movies"
end
