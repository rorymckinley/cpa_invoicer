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

ActiveRecord::Schema.define(version: 20140222111647) do

  create_table "donors", force: true do |t|
    t.string   "donor_no"
    t.string   "initials"
    t.string   "surname"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address1"
    t.string   "address2"
    t.string   "town"
    t.string   "postal_code"
    t.string   "email"
  end

  create_table "motives", force: true do |t|
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "receipts", force: true do |t|
    t.string "receipt_number"
    t.string "donor_name"
    t.text   "donor_address"
    t.text   "line_items"
  end

  create_table "titles", force: true do |t|
    t.integer  "number"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.string   "receipt_number"
    t.integer  "donor_id"
    t.integer  "motive_id"
    t.date     "receipt_date"
    t.decimal  "amount",         precision: 10, scale: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "receipt_id"
  end

end
