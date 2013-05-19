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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130515214750) do

  create_table "applications", :force => true do |t|
    t.integer  "student_id"
    t.integer  "mentor_id"
    t.string   "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "relationship_id"
    t.integer  "game_id"
    t.integer  "champion_id"
    t.integer  "rating"
    t.integer  "premadesize"
    t.integer  "ping"
    t.integer  "spell1"
    t.integer  "spell2"
    t.datetime "date"
    t.integer  "win"
    t.integer  "champions_killed"
    t.integer  "assists"
    t.integer  "num_deaths"
    t.integer  "level"
    t.integer  "minions_killed"
    t.integer  "neutral_minions_killed"
    t.integer  "gold_earned"
    t.integer  "ipearned"
    t.integer  "boostipearned"
    t.integer  "firstwin"
    t.integer  "total_damage_dealt"
    t.integer  "physical_damage_dealt_player"
    t.integer  "magic_damage_dealt_player"
    t.integer  "item0"
    t.integer  "item1"
    t.integer  "item2"
    t.integer  "item3"
    t.integer  "item4"
    t.integer  "item5"
    t.integer  "total_damage_taken"
    t.integer  "physical_damage_taken"
    t.integer  "magic_damage_taken"
    t.integer  "total_heal"
    t.integer  "largest_crititcal_strike"
    t.integer  "largest_multi_kill"
    t.integer  "largest_killing_spree"
    t.integer  "total_time_spent_dead"
    t.integer  "turrets_killed"
    t.integer  "barracks_killed"
    t.integer  "sight_wards_bought_in_game"
    t.integer  "vision_wards_bought_in_game"
    t.integer  "physical_damage_dealt_to_champions"
    t.integer  "magic_damage_dealt_to_champions"
    t.integer  "true_damage_dealt_player"
    t.integer  "true_damage_dealt_to_champions"
    t.integer  "neutral_minions_killed_your_jungle"
    t.integer  "neutral_minions_killed_enemy_jungle"
    t.integer  "total_time_crowd_control_dealt"
    t.integer  "true_damage_taken"
    t.integer  "ward_placed"
    t.integer  "ward_killed"
    t.string   "fellow_players"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
  end

  create_table "messages", :force => true do |t|
    t.integer  "game_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "relationships", :force => true do |t|
    t.integer  "student_id"
    t.integer  "mentor_id"
    t.string   "payment_id"
    t.decimal  "price",      :precision => 8, :scale => 2
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "requests", :force => true do |t|
    t.integer  "student_id"
    t.integer  "mentor_id"
    t.string   "goal_tier"
    t.string   "goal_division"
    t.decimal  "price",         :precision => 8, :scale => 2
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "summonerid"
    t.integer  "acctid"
    t.string   "ign"
    t.string   "server"
    t.string   "roles"
    t.string   "tier"
    t.string   "type"
    t.string   "verify_code"
    t.text     "description"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
