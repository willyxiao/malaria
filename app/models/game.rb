class Game < ActiveRecord::Base
    has_many :players
    belongs_to :community
    
    def shuffle_targets
        players = self.players.shuffle
        
        players[0].target = players[players.length - 1]
        players[0].save!
        
        i = 1
        while i < players.length
            players[i].target = players[i - 1]
            players[i].save!
            i += 1
        end
    end
    
    def self.create_game(community, time_started=Time.new(2016, 04, 11, 3, 0, 0))
        game = self.create!(community: community, time_started: time_started)
        community.users.each do |user|
            Player.create_player(user, game, community)
        end
        game.shuffle_targets
    end
end
