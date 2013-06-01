class Message < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	validates :content, :presence => true, :length => {:minimum => 4}
	attr_accessible :content, :game_id, :user_id
end