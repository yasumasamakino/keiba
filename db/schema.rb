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

ActiveRecord::Schema.define(version: 20161228075050) do

  create_table "horse_bloeds", force: :cascade do |t|
    t.string   "umaCd",      limit: 255
    t.integer  "sedai",      limit: 4
    t.integer  "parentKbn",  limit: 4
    t.string   "bloedUmaCd", limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "horse_bloeds", ["umaCd", "sedai", "parentKbn"], name: "joinIndx", using: :btree
  add_index "horse_bloeds", ["umaCd"], name: "selectIndx", using: :btree

  create_table "horse_hensa_agari_values", force: :cascade do |t|
    t.string   "umaCd",      limit: 255
    t.string   "racecd",     limit: 255
    t.integer  "kyori",      limit: 4
    t.string   "babashurui", limit: 255
    t.float    "speed",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "horse_hensa_values", force: :cascade do |t|
    t.string   "umaCd",      limit: 255
    t.string   "racecd",     limit: 255
    t.integer  "kyori",      limit: 4
    t.string   "babashurui", limit: 255
    t.float    "speed",      limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "horse_hensa_values", ["umaCd", "kyori", "babashurui"], name: "getMaxInd", using: :btree

  create_table "kaishuuritsus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "rentaiProp", limit: 255
    t.float    "rentai",     limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "kaishuuritsus", ["name", "rentaiProp"], name: "slctIndx", using: :btree

  create_table "past_race_tekichuus", force: :cascade do |t|
    t.string   "racecd",     limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "version",    limit: 255
  end

  create_table "past_race_uma_shisuus", force: :cascade do |t|
    t.string   "racecd",      limit: 255
    t.integer  "chakujun",    limit: 4
    t.float    "shisuu",      limit: 24
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "shisuuOrder", limit: 4
    t.float    "fatherRt",    limit: 24
    t.integer  "bloedsScore", limit: 4
    t.float    "speedHensa",  limit: 24
    t.float    "agariHensa",  limit: 24
    t.string   "version",     limit: 255
  end

  create_table "race_pay_raws", force: :cascade do |t|
    t.string   "racecd",     limit: 255
    t.string   "bakenName",  limit: 255
    t.string   "umaban",     limit: 255
    t.string   "pay",        limit: 255
    t.string   "ninki",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "race_pay_raws", ["racecd", "bakenName"], name: "payTmpIndx", using: :btree

  create_table "race_pays", force: :cascade do |t|
    t.string   "racecd",     limit: 255
    t.integer  "no",         limit: 4
    t.integer  "bakenKbn",   limit: 4
    t.string   "umaban",     limit: 255
    t.integer  "ninki",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "pay",        limit: 4
  end

  add_index "race_pays", ["racecd", "bakenKbn"], name: "selectIndx", using: :btree

  create_table "race_result_agari_avgtimes", force: :cascade do |t|
    t.string   "bashocd",       limit: 255
    t.integer  "kyori",         limit: 4
    t.integer  "raceRank",      limit: 4
    t.string   "babashurui",    limit: 255
    t.string   "raceCnt",       limit: 255
    t.float    "timeSecondAvg", limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "race_result_avgtimes", force: :cascade do |t|
    t.string   "bashocd",       limit: 255
    t.integer  "kyori",         limit: 4
    t.integer  "raceRank",      limit: 4
    t.string   "babashurui",    limit: 255
    t.string   "raceCnt",       limit: 255
    t.float    "timeSecondAvg", limit: 24
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "race_result_raws", force: :cascade do |t|
    t.string   "racecd",         limit: 255
    t.integer  "chakujun",       limit: 4
    t.integer  "wakuban",        limit: 4
    t.integer  "umaban",         limit: 4
    t.text     "umaurl",         limit: 65535
    t.text     "bamei",          limit: 65535
    t.text     "seirei",         limit: 65535
    t.string   "kinryou",        limit: 255
    t.text     "kishu",          limit: 65535
    t.text     "kishuurl",       limit: 65535
    t.text     "time",           limit: 65535
    t.text     "chakusa",        limit: 65535
    t.text     "tsuuka",         limit: 65535
    t.text     "agari",          limit: 65535
    t.text     "tanshou",        limit: 65535
    t.integer  "ninki",          limit: 4
    t.text     "bataijuu",       limit: 65535
    t.text     "choukyoushi",    limit: 65535
    t.text     "choukyoushiurl", limit: 65535
    t.text     "banushi",        limit: 65535
    t.text     "banushiurl",     limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "race_results", force: :cascade do |t|
    t.string   "racecd",        limit: 255
    t.integer  "chakujun",      limit: 4
    t.integer  "wakuban",       limit: 4
    t.integer  "umaban",        limit: 4
    t.string   "umaCd",         limit: 255
    t.integer  "sei",           limit: 4
    t.integer  "rei",           limit: 4
    t.float    "kinryou",       limit: 24
    t.string   "kishuCd",       limit: 255
    t.string   "time",          limit: 255
    t.string   "chakusa",       limit: 255
    t.float    "agari",         limit: 24
    t.float    "tanshou",       limit: 24
    t.integer  "ninki",         limit: 4
    t.integer  "bataijuu",      limit: 4
    t.integer  "zougen",        limit: 4
    t.string   "choukyoushiCd", limit: 255
    t.string   "banushiCd",     limit: 255
    t.string   "tsuuka",        limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.float    "timeSecond",    limit: 24
  end

  add_index "race_results", ["kishuCd"], name: "slctKishu", using: :btree
  add_index "race_results", ["racecd"], name: "index_race_results_on_racecd", using: :btree
  add_index "race_results", ["racecd"], name: "raceIndx", using: :btree
  add_index "race_results", ["umaCd"], name: "index_race_results_on_umaCd", using: :btree

  create_table "race_rows", force: :cascade do |t|
    t.string   "racecd",        limit: 255
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "lap",           limit: 255
    t.string   "pacd",          limit: 255
    t.string   "raceTitle",     limit: 255
    t.string   "raceDatePlace", limit: 255
  end

  create_table "race_tousuus", force: :cascade do |t|
    t.string   "racecd",     limit: 255
    t.integer  "tousuu",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "race_tousuus", ["racecd"], name: "raceCd", using: :btree
  add_index "race_tousuus", ["racecd"], name: "sctIndx", using: :btree

  create_table "races", force: :cascade do |t|
    t.string   "racecd",       limit: 255
    t.string   "name",         limit: 255
    t.date     "kaisaibi"
    t.string   "bashocd",      limit: 255
    t.integer  "babashurui",   limit: 4
    t.integer  "babajoutai",   limit: 4
    t.integer  "tenkou",       limit: 4
    t.time     "hassoujikoku"
    t.integer  "kyori",        limit: 4
    t.integer  "mawari",       limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.integer  "raceRank",     limit: 4
  end

  add_index "races", ["bashocd", "babashurui", "kyori", "kaisaibi"], name: "slctTokui", using: :btree
  add_index "races", ["racecd", "babashurui", "kaisaibi"], name: "bloedIndx", using: :btree
  add_index "races", ["racecd", "kaisaibi"], name: "slctKaisai", using: :btree
  add_index "races", ["racecd"], name: "index_races_on_racecd", using: :btree

  create_table "rentaiba_tsuukas", force: :cascade do |t|
    t.string   "umaCd",      limit: 255
    t.string   "racecd",     limit: 255
    t.integer  "no",         limit: 4
    t.integer  "position",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "chakujun",   limit: 4
    t.integer  "babashurui", limit: 4
  end

  add_index "rentaiba_tsuukas", ["racecd", "umaCd"], name: "unqIndx", using: :btree
  add_index "rentaiba_tsuukas", ["umaCd", "racecd"], name: "selectIndx", using: :btree

  create_table "rentairitsus", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "rentaiProp", limit: 255
    t.float    "rentai",     limit: 24
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "rentairitsus", ["name", "rentaiProp"], name: "selectIndx", using: :btree

end
