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

ActiveRecord::Schema.define(version: 2020_04_04_221702) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "item_orders", force: :cascade do |t|
    t.bigint "item_id"
    t.bigint "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_item_orders_on_item_id"
    t.index ["order_id"], name: "index_item_orders_on_order_id"
  end

  create_table "items", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.binary "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_sources", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_sources_on_order_id"
    t.index ["source_id"], name: "index_order_sources_on_source_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "published_at"
    t.boolean "deprecated", default: false
    t.date "deprecated_at"
  end

  create_table "orders_of_items", force: :cascade do |t|
    t.bigint "orders_id"
    t.bigint "items_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["items_id"], name: "index_orders_of_items_on_items_id"
    t.index ["orders_id"], name: "index_orders_of_items_on_orders_id"
  end

  create_table "sources", force: :cascade do |t|
    t.string "link"
    t.binary "resource"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
  end

  create_table "sources_of_orders", force: :cascade do |t|
    t.bigint "sources_id"
    t.bigint "orders_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["orders_id"], name: "index_sources_of_orders_on_orders_id"
    t.index ["sources_id"], name: "index_sources_of_orders_on_sources_id"
  end

  add_foreign_key "orders_of_items", "items", column: "items_id"
  add_foreign_key "orders_of_items", "orders", column: "orders_id"
  add_foreign_key "sources_of_orders", "orders", column: "orders_id"
  add_foreign_key "sources_of_orders", "sources", column: "sources_id"
end
