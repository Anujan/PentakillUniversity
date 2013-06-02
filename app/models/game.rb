class Game < ActiveRecord::Base
  belongs_to :relationship
  serialize :fellow_players

  attr_accessible :assists, :barracks_killed, :boostipearned, :champion_id, :champions_killed, :date, :firstwin, :game_id, :gold_earned, :id, 
  :ipearned, :item0, :item1, :item2, :item3, :item4, :item5, :largest_crititcal_strike, :largest_killing_spree, :largest_multi_kill, :level, 
  :magic_damage_dealt_player, :magic_damage_dealt_to_champions, :magic_damage_taken, :minions_killed, :neutral_minions_killed, 
  :neutral_minions_killed_enemy_jungle, :neutral_minions_killed_your_jungle, :num_deaths, :physical_damage_dealt_player, 
  :physical_damage_dealt_to_champions, :physical_damage_taken, :ping, :premadesize, :rating, :relationship_id, :sight_wards_bought_in_game, 
  :spell1, :spell2, :total_damage_dealt, :total_damage_taken, :total_heal, :total_time_crowd_control_dealt, :total_time_spent_dead, 
  :true_damage_dealt_player, :true_damage_dealt_to_champions, :true_damage_taken, :turrets_killed, :vision_wards_bought_in_game, :ward_killed, 
  :ward_placed, :win, :fellow_players, :relationship_id

  def update_stats(stats)
  	self.date = stats[:createDate]
  	self.game_id = stats[:gameId]
  	self.firstwin = stats[:eligibleFirstWinOfDay]
  	self.fellow_players = stats[:fellowPlayers]
  	self.spell1 = stats[:spell1]
  	self.spell2 = stats[:spell2]
  	self.champion_id = stats[:championId]
  	self.ping = stats[:userServerPing]
  	self.premadesize = stats[:premadeTeam] ? 1 : 0
  	stats[:statistics][:array].each do |key, val|
      key.downcase!
  		self.send("#{key}=", val)
  	end
  	self.save
  end

  def item_string
    items = [item0, item1, item2, item3, item4, item5]
    itemNames = []
    items.each do |item|
      itemNames << Thing.find(item).name if item > 0
    end
    return itemNames.join(", ")
  end

  def champion_name
    return Thing.find(champion_id).name
  end

  def estimated_time_string
    ip = ipearned - boostipearned
    if (win > 0 && firstwin > 0)
      ip -= 150;
    end
    base = win > 0 ? 18 : 16
    perMin = win > 0 ? 2.312 : 1.405
    time = (ip - base) / perMin
    return time.to_i.to_s
  end
end