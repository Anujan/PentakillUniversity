require 'json'
require 'socket'

class User < ActiveRecord::Base
  serialize :roles
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  validates :ign, :server, :roles, :presence => true
  validate :summoner_exists
  validate :valid_roles
  attr_accessible :email, :password, :password_confirmation, :remember_me, :ign, :server, :tier, :roles, :type, :verify_code

  def valid_roles
    valid_role_array = ['Top', 'Mid', 'Jungle', 'AD Carry', 'Support']
    roles.each do |role| 
      unless valid_role_array.include?(role)
        roles.delete(role)
      end
    end
  end

  def is_mentor?
    return type == 'Mentor'
  end
  
  def summoner_verified?
    return verify_code == 'VERIFIED'
  end
  
  def summoner_verify
    rune_pages = shurima_api(server, 'rune_pages', acctid)
    unless rune_pages
      return false
    else
      rune_pages.each do |page|
        if (page['name'] == verify_code)
          verify_code = 'VERIFIED'
          return save
        end
      end
    end
    return false
  end
  
  def summoner_exists
    unless (server_changed? || ign_changed? || new_record?)
      return
    end
    json = shurima_api(server, 'summoner', ign)
    unless json
      errors.add(:ign, "The summoner name \"#{ign}\" doesn't exist on #{server}")
    else
      summonerid = json['summonerId']
      acctid = json['acctId']
      if (verify_code.empty?) 
        verify_code = Array.new(10){rand(36).to_s(36)}.join
      end
      eligible_to_mentor
    end
  end
  
  def eligible_to_mentor
    leagues = shurima_api(server, 'leagues', summonerid)
    unless leagues
      errors.add(:ign, "That summoner doesn't seem to meet the requirements to become a mentor. Make sure you're at least in a Platinum League")
      return false
    end
    leagues.each do |league| 
      if (league['queue'] == 'RANKED_SOLO_5x5')
        tier = league['tier']
      end
    end
    eligible_tiers = ['PLATINUM', 'DIAMOND', 'CHALLENGER']
    if (type == 'Mentor' && !eligible_tiers.include?(tier))
      errors.add(:mentor, "Mentors must be at least PLATINUM.")
    end
  end
  
  def shurima_api(server, method, args)
    host, port = '78.129.218.131', 714
    TCPSocket.open(host, port) do |socket|
      ready = IO.select([socket], [socket], nil, 8)
      unless (ready) 
        return falses
      end
      socket.puts server + "&" + method + "&" + args.to_s
      message = socket.gets.chomp
      if message == '"Unknown error"'
        return false
      end
      return JSON.parse(message)
    end
  end
end
