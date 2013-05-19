require 'json'
require 'socket'

class User < ActiveRecord::Base
  serialize :roles
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable
  validates :ign, :server, :roles, :presence => true
  validate :summoner_exists
  validate :valid_roles
  attr_accessible :email, :password, :password_confirmation, :remember_me, :ign, :server, :tier, :roles, :type

  
  def valid_roles
    valid_role_array = ['Top', 'Mid', 'Jungle', 'AD Carry', 'Support']
    self.roles.each do |role| 
      unless valid_role_array.include?(role)
        self.roles.delete(role)
      end
    end
  end
  
  def summoner_verified?
    return self.verify_code == 'VERIFIED'
  end
  
  def summoner_verify
    rune_pages = shurima_api(self.server, 'rune_pages', self.acctid)
    unless rune_pages
      return false
    else
      rune_pages.each do |page|
        if (page['name'] == self.verify_code)
          self.verify_code = 'VERIFIED'
          self.save
          return true
        end
      end
    end
    return false
  end
  
  def summoner_exists
    json = shurima_api(self.server, 'summoner', self.ign)
    unless json
      errors.add(:ign, "The summoner name \"#{self.ign}\" doesn't exist on #{self.server}")
    else
      self.summonerid = json['summonerId']
      self.acctid = json['acctId']
      self.verify_code = Array.new(10){rand(36).to_s(36)}.join
      eligible_to_mentor
    end
  end
  
  def eligible_to_mentor
    leagues = shurima_api(self.server, 'leagues', self.summonerid)
    unless leagues
      errors.add(:ign, "That summoner doesn't seem to meet the requirements to become a mentor. Make sure you're at least in a Platinum League")
      return false
    end
    leagues.each do |league| 
      if (league['queue'] == 'RANKED_SOLO_5x5')
        self.tier = league['tier']
      end
    end
    eligible_tiers = ['PLATINUM', 'DIAMOND', 'CHALLENGER']
    if (self.type == 'Mentor' && !eligible_tiers.include?(self.tier))
      errors.add(:mentor, "Mentors must be at least PLATINUM.")
    end
  end
  
  def shurima_api(server, method, args)
    host, port = '78.129.218.131', 714
    TCPSocket.open(host, port) do |socket|
      ready = IO.select([socket], [socket], nil, 8)
      return false unless ready
      socket.puts server + "&" + method + "&" + args.to_s
      message = socket.gets.chomp
      if message == '"Unknown error"'
        return false
      end
      return JSON.parse(message)
    end
  end
end
