class Relationship < ActiveRecord::Base
	belongs_to :student, :class_name => 'Student', :foreign_key => 'student_id'
	belongs_to :mentor, :class_name => 'Mentor', :foreign_key => 'mentor_id'
	has_many :games
	validates :mentor_id, :uniqueness => { :scope => :student_id }
	attr_accessible :id, :mentor_id, :payment_id, :student_id, :price, :mentor, :last_game
	
	def update_games
		new_games = shurima_api(student.server, 'recent_games', student.acctid)
		if (new_games)
			new_last_game_id = self.last_game
			new_games[:array].each do |game_info|
				game_id = game_info[:gameId]
				if (game_id > self.last_game && game_info[:ranked] && game_info[:gameMapId] == 1)
					new_game = Games.new()
					new_game.relationship_id = self.id
					new_game.update_stats(game_info)
					new_game.save!
					new_last_game_id = game_id if game_id > new_last_game_id
				end
			end
		end
	end

	def shurima_api(server, method, args)
		host, port = '78.129.218.131', 714
		TCPSocket.open(host, port) do |socket|
			socket.puts server + "&" + method + "&" + args.to_s
			message = socket.gets.chomp
			if message == '"Unknown error"'
				return false
			end
			return JSON.parse(message)
		end
	end
end
