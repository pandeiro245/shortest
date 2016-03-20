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

ActiveRecord::Schema.define(version: 20160320034423) do

  create_table "knowledges", force: :cascade do |t|
    t.integer  "word_id",    limit: 4
    t.integer  "tweet_id",   limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "knowledges", ["tweet_id"], name: "index_knowledges_on_tweet_id", using: :btree
  add_index "knowledges", ["word_id"], name: "index_knowledges_on_word_id", using: :btree

  create_table "tweets", force: :cascade do |t|
    t.integer  "twitter_id",            limit: 8
    t.string   "text",                  limit: 255
    t.string   "text_escaped",          limit: 255
    t.integer  "in_reply_to_status_id", limit: 8
    t.boolean  "mecabed",                           default: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.integer  "favorite_count",        limit: 4
    t.integer  "retweet_count",         limit: 4
  end

  create_table "users", force: :cascade do |t|
    t.integer  "twitter_id",                   limit: 8
    t.string   "twitter_screen_name",          limit: 255
    t.string   "twitter_profile_image_url",    limit: 255
    t.text     "twitter_profile_image_base64", limit: 65535
    t.string   "twitter_token",                limit: 255
    t.string   "twitter_secret",               limit: 255
    t.string   "email",                        limit: 255,   default: "", null: false
    t.string   "encrypted_password",           limit: 255,   default: "", null: false
    t.string   "reset_password_token",         limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",           limit: 255
    t.string   "last_sign_in_ip",              limit: 255
    t.integer  "instagram_id",                 limit: 4
    t.string   "instagram_token",              limit: 255
    t.string   "instagram_image",              limit: 255
    t.string   "instagram_nickname",           limit: 255
  end

  create_table "words", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "wikipedia",  limit: 16777215
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "knowledges", "words"
end
