class Game < ActiveRecord::Base
    has_many :players
    belongs_to :community
    
    def shuffle_targets
        players = self.players.where.not(target_id: nil).shuffle
        
        players[0].target = players[players.length - 1]
        players[0].save!
        
        i = 1
        while i < players.length
            players[i].target = players[i - 1]
            players[i].save!
            i += 1
        end
    end
    
    def fix_killstories
        # fix representation of death in the database
        SiteEvent.create(event: "Fixing target_id for deads in game #{self.id}")
        Killstory.where(game: self).all.each do |killstory|
            player = Player.find(killstory.dead_id)
            player.target_id = nil
            player.save
        end
    end
    
    def fix_take_no_kill
        self.fix_killstories()

        # this needs to be fixed!    
        # players = self.players.where.not(target_id: nil).all
        # players.each do |player|
        #     if Killstory.where(killer_id: player.id).count == 0
        #         assassin = player.assassin
        #         assassin.target = player.target
        #         player.target_id = nil
        #         assassin.save
        #         player.save
        #         SiteEvent.create(event: "Setting #{assassin.id} target to #{assassin.target_id} because #{player.id} made no kills")
        #     end
        # end
    end
    
    def self.create_game(community, time_started=Time.new(2016, 04, 11, 3, 0, 0))
        game = self.create!(community: community, time_started: time_started)
        community.users.each do |user|
            Player.create_player(user, game, community)
        end
        game.shuffle_targets
    end
end
