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

ActiveRecord::Schema.define(version: 2020_05_29_045637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.datetime "registered_at", default: -> { "CURRENT_TIMESTAMP" }
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "postal_code"
    t.string "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "videos_checked_out_count", default: 0
  end

  create_table "rentals", force: :cascade do |t|
    t.date "due_date"
    t.date "checkin_date"
    t.date "checkout_date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "customer_id"
    t.index ["customer_id"], name: "index_rentals_on_customer_id"
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "overview"
    t.string "release_date"
    t.integer "total_inventory"
    t.integer "available_inventory"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "rentals", "customers"
end
