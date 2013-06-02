require 'json'
require 'net/http'
class CreateThings < ActiveRecord::Migration
	def up
		create_table :things do |t|
			t.integer :id
			t.string :name
		end
		url = "http://shurima.net/api/champions/items"
		json = JSON.parse(Net::HTTP.get_response(URI.parse(url)).body)
		json.each do |entry|
			Thing.create(id: entry["id"], name: entry["displayName"])	
		end
	end

	def down
		drop_table :things
	end
end
