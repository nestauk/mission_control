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

ActiveRecord::Schema[7.0].define(version: 2022_08_01_115341) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.bigint "person_id"
    t.bigint "organisation_id"
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.string "email"
    t.string "phone"
    t.string "position"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organisation_id"], name: "index_contacts_on_organisation_id"
    t.index ["person_id"], name: "index_contacts_on_person_id"
  end

  create_table "contributions", force: :cascade do |t|
    t.bigint "goal_id"
    t.bigint "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_contributions_on_goal_id"
    t.index ["project_id"], name: "index_contributions_on_project_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.string "shortname"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "impact_ratings", force: :cascade do |t|
    t.string "impactable_type"
    t.bigint "impactable_id"
    t.integer "contribution_type", null: false
    t.string "hypothesis"
    t.integer "confidence", null: false
    t.integer "no_people_reached"
    t.string "audience_description"
    t.string "potential_reach"
    t.integer "scale_likelihood"
    t.float "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["impactable_type", "impactable_id"], name: "index_impact_ratings_on_impactable"
  end

  create_table "indicators", force: :cascade do |t|
    t.string "targetable_type"
    t.bigint "targetable_id"
    t.string "title"
    t.integer "status", default: 0
    t.date "start_date"
    t.date "end_date"
    t.string "unit"
    t.float "target_value"
    t.date "last_progress_update_date"
    t.integer "last_progress_update_status"
    t.float "last_progress_update_value"
    t.integer "update_frequency", default: 0
    t.datetime "last_reminded_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["targetable_type", "targetable_id"], name: "index_indicators_on_targetable"
  end

  create_table "links", force: :cascade do |t|
    t.string "linkable_type"
    t.bigint "linkable_id"
    t.string "url", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_type", "linkable_id"], name: "index_links_on_linkable"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "contact_id"
    t.string "memberable_type"
    t.bigint "memberable_id"
    t.integer "role", null: false
    t.integer "role_type", null: false
    t.string "description"
    t.float "avg_weekly_time_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_memberships_on_contact_id"
    t.index ["memberable_type", "memberable_id"], name: "index_memberships_on_memberable"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.string "pronouns"
    t.string "first_name"
    t.string "last_name"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "progress_updates", force: :cascade do |t|
    t.bigint "indicator_id"
    t.bigint "user_id"
    t.date "date"
    t.float "value"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["indicator_id"], name: "index_progress_updates_on_indicator_id"
    t.index ["user_id"], name: "index_progress_updates_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.integer "status", default: 0
    t.string "objective"
    t.date "start_date"
    t.date "end_date"
    t.integer "estimated_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable"
  end

  create_table "tags", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contact_id"
    t.index ["contact_id"], name: "index_users_on_contact_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
