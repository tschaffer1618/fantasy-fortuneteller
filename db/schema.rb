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

ActiveRecord::Schema.define(version: 2019_10_28_203752) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "players", force: :cascade do |t|
    t.integer "active"
    t.integer "jersey"
    t.string "lname"
    t.string "fname"
    t.string "display_name"
    t.string "team"
    t.string "position"
    t.string "height"
    t.integer "weight"
    t.string "college"
    t.string "experience"
    t.string "birth_date"
    t.string "photo_url"
    t.integer "bye_week"
    t.integer "ffn_id"
    t.integer "projection_week", default: 0
    t.float "current_projection", default: 0.0
    t.string "injury_status"
  end

  create_table "team_players", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "player_id"
    t.boolean "benched", default: true
    t.index ["player_id"], name: "index_team_players_on_player_id"
    t.index ["team_id"], name: "index_team_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_teams_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider"
    t.string "uid"
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "google_token"
    t.string "google_refresh_token"
    t.string "picture"
    t.boolean "verified", default: false
    t.datetime "google_oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role", default: 0
  end

  add_foreign_key "team_players", "players"
  add_foreign_key "team_players", "teams"
  add_foreign_key "teams", "users"
end
