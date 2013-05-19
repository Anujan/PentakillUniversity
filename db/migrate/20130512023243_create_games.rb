class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :relationship_id
      t.integer :game_id
      t.integer :champion_id
      t.integer :rating
      t.integer :premadesize
      t.integer :ping
      t.integer :spell1
      t.integer :spell2
      t.datetime :date
      t.integer :win
      t.integer :champions_killed
      t.integer :assists
      t.integer :num_deaths
      t.integer :level
      t.integer :minions_killed
      t.integer :neutral_minions_killed
      t.integer :gold_earned
      t.integer :ipearned
      t.integer :boostipearned
      t.integer :firstwin
      t.integer :total_damage_dealt
      t.integer :physical_damage_dealt_player
      t.integer :magic_damage_dealt_player
      t.integer :item0
      t.integer :item1
      t.integer :item2
      t.integer :item3
      t.integer :item4
      t.integer :item5
      t.integer :total_damage_taken
      t.integer :physical_damage_taken
      t.integer :magic_damage_taken
      t.integer :total_heal
      t.integer :largest_crititcal_strike
      t.integer :largest_multi_kill
      t.integer :largest_killing_spree
      t.integer :total_time_spent_dead
      t.integer :turrets_killed
      t.integer :barracks_killed
      t.integer :sight_wards_bought_in_game
      t.integer :vision_wards_bought_in_game
      t.integer :physical_damage_dealt_to_champions
      t.integer :magic_damage_dealt_to_champions
      t.integer :true_damage_dealt_player
      t.integer :true_damage_dealt_to_champions
      t.integer :neutral_minions_killed_your_jungle
      t.integer :neutral_minions_killed_enemy_jungle
      t.integer :total_time_crowd_control_dealt
      t.integer :true_damage_taken
      t.integer :ward_placed
      t.integer :ward_killed
      t.string :fellow_players

      t.timestamps
    end
  end
end
