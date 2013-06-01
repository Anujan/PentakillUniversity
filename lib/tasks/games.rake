require 'rake'
require 'json'
require "redis"
require 'net/http'

namespace :games do
	desc "Update all relationships"
	task :update => :environment do 
		Relationship.all.each do |r| 
			r.update_games
		end
	end
end
