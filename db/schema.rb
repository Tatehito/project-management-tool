# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_06_135945) do

  create_table "meeting_members", force: :cascade do |t|
    t.integer "member_id", null: false
    t.integer "meeting_id", null: false
    t.boolean "organizer"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["meeting_id"], name: "index_meeting_members_on_meeting_id"
    t.index ["member_id"], name: "index_meeting_members_on_member_id"
  end

  create_table "meetings", force: :cascade do |t|
    t.integer "team_id", null: false
    t.integer "room_id", null: false
    t.string "name"
    t.date "start"
    t.date "end"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["room_id"], name: "index_meetings_on_room_id"
    t.index ["team_id"], name: "index_meetings_on_team_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.boolean "owner", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "team_members", force: :cascade do |t|
    t.boolean "leader", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "team_id"
    t.integer "member_id"
    t.index ["member_id"], name: "index_team_members_on_member_id"
    t.index ["team_id"], name: "index_team_members_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "meeting_members", "meetings"
  add_foreign_key "meeting_members", "members"
  add_foreign_key "meetings", "rooms"
  add_foreign_key "meetings", "teams"
  add_foreign_key "team_members", "members"
  add_foreign_key "team_members", "teams"
end
