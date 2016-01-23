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

ActiveRecord::Schema.define(version: 20160123170731) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",         null: false
    t.string   "password_hash"
    t.integer  "school_id"
  end

  create_table "communities", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",       null: false
    t.string   "hash1",      null: false
    t.string   "hash2",      null: false
    t.string   "hash3",      null: false
    t.integer  "school_id"
  end

  create_table "friends", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "community_id", null: false
    t.datetime "time_started", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: :cascade do |t|
    t.integer  "community_id",                null: false
    t.integer  "user_id",                     null: false
    t.integer  "game_id",                     null: false
    t.integer  "target_id"
    t.boolean  "state",        default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                             null: false
    t.string   "email"
    t.boolean  "confirmed_email",  default: false, null: false
    t.string   "provider",                         null: false
    t.string   "uid",                              null: false
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.integer  "community_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "image"
    t.string   "email_hash"
  end

end
