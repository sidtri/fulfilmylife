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

ActiveRecord::Schema.define(version: 20180724153034) do

  create_table "card_templates", force: :cascade do |t|
    t.string   "name"
    t.integer  "card_id"
    t.integer  "event_id"
    t.integer  "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_card_templates_on_card_id"
    t.index ["event_id"], name: "index_card_templates_on_event_id"
    t.index ["program_id"], name: "index_card_templates_on_program_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string   "title"
    t.string   "sub_title"
    t.string   "total_time"
    t.string   "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "tag"
    t.string   "slug"
    t.string   "references"
    t.text     "parsed_content"
    t.integer  "days"
    t.integer  "program_id"
    t.integer  "category_id"
    t.index ["category_id"], name: "index_cards_on_category_id"
    t.index ["program_id"], name: "index_cards_on_program_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_time"
    t.text     "recurring"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "end_time"
    t.integer  "card_id"
    t.index ["card_id"], name: "index_events_on_card_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "new_surveys", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "question_id"
    t.string   "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["card_id"], name: "index_new_surveys_on_card_id"
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.string   "period"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "active",     default: false
  end

  create_table "programs_users", id: false, force: :cascade do |t|
    t.integer "program_id"
    t.integer "user_id"
    t.index ["program_id"], name: "index_programs_users_on_program_id"
    t.index ["user_id"], name: "index_programs_users_on_user_id"
  end

  create_table "progresses", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_progresses_on_card_id"
    t.index ["user_id"], name: "index_progresses_on_user_id"
  end

  create_table "stats", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "card_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_stats_on_card_id"
    t.index ["user_id"], name: "index_stats_on_user_id"
  end

  create_table "survey_answers", force: :cascade do |t|
    t.integer  "attempt_id"
    t.integer  "question_id"
    t.integer  "option_id"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "option_text"
    t.integer  "option_number"
    t.integer  "predefined_value_id"
  end

  create_table "survey_attempts", force: :cascade do |t|
    t.string  "participant_type"
    t.integer "participant_id"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "weight",          default: 0
    t.string   "text"
    t.boolean  "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale_text"
    t.integer  "options_type_id"
    t.string   "head_number"
  end

  create_table "survey_predefined_values", force: :cascade do |t|
    t.string   "head_number"
    t.string   "name"
    t.string   "locale_name"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.string   "head_number"
    t.text     "description"
    t.string   "locale_text"
    t.string   "locale_head_number"
    t.text     "locale_description"
    t.integer  "questions_type_id"
    t.boolean  "mandatory",          default: false
  end

  create_table "survey_sections", force: :cascade do |t|
    t.string   "head_number"
    t.string   "name"
    t.text     "description"
    t.integer  "survey_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale_head_number"
    t.string   "locale_name"
    t.text     "locale_description"
  end

  create_table "survey_surveys", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "attempts_number",    default: 0
    t.boolean  "finished",           default: false
    t.boolean  "active",             default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "locale_name"
    t.text     "locale_description"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "name"
    t.string   "gc_session_id"
    t.string   "access_token"
    t.datetime "expires_in"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
