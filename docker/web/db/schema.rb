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

ActiveRecord::Schema.define(version: 20150324221341) do

  create_table "activities", force: :cascade do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type", limit: 255
    t.integer  "owner_id"
    t.string   "owner_type",     limit: 255
    t.string   "key",            limit: 255
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "alerts", force: :cascade do |t|
    t.string "email", limit: 255, null: false
  end

  add_index "alerts", ["email"], name: "index_alerts_on_email", unique: true

  create_table "badges_sashes", force: :cascade do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id"
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id"
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id"

  create_table "bids", force: :cascade do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.float    "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "code"
    t.datetime "completed_at"
    t.boolean  "pending",                  default: true,         null: false
    t.string   "state",        limit: 255, default: "incomplete", null: false
  end

  create_table "code_reviews", force: :cascade do |t|
    t.boolean  "pending",                default: true, null: false
    t.string   "title",      limit: 255
    t.text     "markdown"
    t.string   "language",   limit: 255
    t.integer  "bid_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "code_reviews_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "code_review_id"
  end

  add_index "code_reviews_users", ["code_review_id"], name: "index_code_reviews_users_on_code_review_id"
  add_index "code_reviews_users", ["user_id"], name: "index_code_reviews_users_on_user_id"

  create_table "invitations", force: :cascade do |t|
    t.string  "code",           limit: 255
    t.integer "invitable_id"
    t.string  "invitable_type", limit: 255
    t.string  "email",          limit: 255
    t.string  "type",           limit: 255, default: "", null: false
    t.string  "invite_type",    limit: 255
  end

  add_index "invitations", ["code"], name: "index_invitations_on_code", unique: true
  add_index "invitations", ["email"], name: "index_invitations_on_email", unique: true

  create_table "juniors", force: :cascade do |t|
  end

  create_table "languages", force: :cascade do |t|
    t.string  "name",              limit: 255
    t.integer "languageable_id"
    t.string  "languageable_type", limit: 255
  end

  create_table "merit_actions", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "action_method", limit: 255
    t.integer  "action_value"
    t.boolean  "had_errors",                default: false
    t.string   "target_model",  limit: 255
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: :cascade do |t|
    t.integer  "action_id"
    t.string   "related_change_type", limit: 255
    t.integer  "related_change_id"
    t.string   "description",         limit: 255
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: :cascade do |t|
    t.integer  "score_id"
    t.integer  "num_points",             default: 0
    t.string   "log",        limit: 255
    t.datetime "created_at"
  end

  create_table "merit_scores", force: :cascade do |t|
    t.integer "sash_id"
    t.string  "category", limit: 255, default: "default"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "title",        limit: 255
    t.string   "description",  limit: 255
    t.string   "repo_url",     limit: 255
    t.datetime "due_date"
    t.boolean  "is_available"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar",       limit: 255
    t.integer  "user_id"
    t.integer  "views",                    default: 0,     null: false
    t.boolean  "is_accepted",              default: false, null: false
    t.string   "git_url"
    t.float    "spend",                    default: 0.0,   null: false
    t.string   "slug"
  end

  create_table "sashes", force: :cascade do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seniors", force: :cascade do |t|
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", force: :cascade do |t|
    t.string  "name",           limit: 255
    t.integer "taggings_count",             default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",    null: false
    t.string   "encrypted_password",     limit: 255, default: "",    null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "github_profile_url",     limit: 255
    t.string   "company",                limit: 255
    t.string   "location",               limit: 255
    t.boolean  "hireable",                           default: false, null: false
    t.string   "avatar",                 limit: 255
    t.boolean  "avatar_processing",                  default: false, null: false
    t.string   "avatar_tmp",             limit: 255
    t.string   "provider",               limit: 255
    t.string   "uid",                    limit: 255
    t.boolean  "senior",                             default: false, null: false
    t.boolean  "admin",                              default: false, null: false
    t.float    "wallet",                             default: 0.0,   null: false
    t.string   "username",               limit: 255
    t.integer  "followable_id"
    t.string   "followable_type",        limit: 255
    t.string   "auth_token",             limit: 255
    t.integer  "sash_id"
    t.integer  "level",                              default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["followable_id", "followable_type"], name: "index_users_on_followable_id_and_followable_type"
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

end
