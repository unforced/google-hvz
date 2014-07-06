# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20140702194517) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: true do |t|
    t.integer  "mission_id"
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "feeds", force: true do |t|
    t.integer  "tag_id"
    t.integer  "player_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "games", force: true do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "missions", force: true do |t|
    t.datetime "time"
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.integer  "faction"
    t.string   "tag_code"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "players", ["game_id"], name: "index_players_on_game_id", using: :btree
  add_index "players", ["user_id"], name: "index_players_on_user_id", using: :btree

  create_table "tags", force: true do |t|
    t.integer  "tagger_id"
    t.integer  "tagee_id"
    t.datetime "time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
    t.string  "email"
    t.string  "ldap"
    t.boolean "admin"
    t.string  "phone_number"
  end

end
