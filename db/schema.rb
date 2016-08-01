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

ActiveRecord::Schema.define(version: 20160727115019) do

  create_table "client_senders", force: :cascade do |t|
    t.integer  "client_id",  limit: 4
    t.integer  "sender_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "client_senders", ["client_id"], name: "index_client_senders_on_client_id", using: :btree
  add_index "client_senders", ["sender_id"], name: "index_client_senders_on_sender_id", using: :btree

  create_table "clients", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "token",      limit: 255
    t.boolean  "active",                 default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "host",       limit: 255
  end

  create_table "e_messages", force: :cascade do |t|
    t.string   "message",          limit: 255
    t.string   "subject",          limit: 255
    t.string   "sender_name",      limit: 255
    t.string   "sender_email",     limit: 255
    t.string   "token",            limit: 255
    t.boolean  "async",                        default: false
    t.boolean  "is_message_valid",             default: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "senders", force: :cascade do |t|
    t.string   "name",            limit: 255
    t.boolean  "active",                      default: false
    t.string   "sender_class",    limit: 255
    t.string   "additional_data", limit: 255
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "sent_e_messages", force: :cascade do |t|
    t.string   "status",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.datetime "date_sent"
    t.integer  "e_message_id", limit: 4
    t.integer  "sender_id",    limit: 4
    t.string   "message",      limit: 255
  end

  add_index "sent_e_messages", ["e_message_id"], name: "index_sent_e_messages_on_emessage_id", using: :btree
  add_index "sent_e_messages", ["sender_id"], name: "index_sent_e_messages_on_sender_id", using: :btree

end
