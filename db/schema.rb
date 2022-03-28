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

ActiveRecord::Schema[7.0].define(version: 2022_03_19_110430) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "video_id"
    t.integer "user_id"
    t.string "comment"
    t.integer "reference_comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference_comment_id"], name: "index_comments_on_reference_comment_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["video_id"], name: "index_comments_on_video_id"
  end

  create_table "user_subscribes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subcribe_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subcribe_user_id"], name: "index_user_subscribes_on_subcribe_user_id"
    t.index ["user_id"], name: "index_user_subscribes_on_user_id"
  end

  create_table "user_videos", force: :cascade do |t|
    t.integer "user_id"
    t.integer "video_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_user_videos_on_status"
    t.index ["user_id"], name: "index_user_videos_on_user_id"
    t.index ["video_id"], name: "index_user_videos_on_video_id"
  end

  create_table "user_vote_videos", force: :cascade do |t|
    t.integer "video_id"
    t.integer "user_id"
    t.integer "direction", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["direction"], name: "index_user_vote_videos_on_direction"
    t.index ["user_id"], name: "index_user_vote_videos_on_user_id"
    t.index ["video_id"], name: "index_user_vote_videos_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "user_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "thumbnail"
    t.integer "upload_user_id"
    t.integer "total_likes", default: 0
    t.integer "total_dislikes", default: 0
    t.integer "total_view", default: 0
    t.string "video_url"
    t.integer "status", default: 0
    t.integer "platform", default: 0
    t.jsonb "meta_data", default: {}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meta_data"], name: "index_videos_on_meta_data", using: :gin
    t.index ["upload_user_id"], name: "index_videos_on_upload_user_id"
  end

end
