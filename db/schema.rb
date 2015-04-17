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

ActiveRecord::Schema.define(version: 20150416235912) do

  create_table "costs", force: true do |t|
    t.string  "name"
    t.text    "description"
    t.float   "price"
    t.integer "vehicle_id"
  end

  add_index "costs", ["vehicle_id"], name: "index_costs_on_vehicle_id"

  create_table "users", force: true do |t|
    t.string   "uname"
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: true do |t|
    t.string   "make"
    t.string   "model"
    t.integer  "year"
    t.float    "sellprice"
    t.float    "buyprice"
    t.integer  "kilometers_travelled"
    t.string   "engine_capacity"
    t.string   "colour"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "security_interest"
    t.boolean  "radio_receiver"
    t.boolean  "re_registered_vehicle"
    t.boolean  "road_user_charges"
    t.boolean  "outstanding_road_user_charges"
    t.boolean  "imported"
    t.boolean  "imported_damaged"
    t.string   "warrant_expiry"
    t.string   "vehicle_licence_expiry"
    t.integer  "first_registered"
    t.integer  "first_registered_overseas"
    t.string   "country_last_registered"
    t.string   "registration_number"
    t.string   "vin_number"
    t.string   "fuel_type"
    t.string   "main_picture"
    t.string   "purchase_date"
    t.string   "sale_date"
    t.integer  "stock_number"
  end

end
