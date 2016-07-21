class Game < ActiveRecord::Base
    has_many :players
    has_many :player_stats
    belongs_to :community
    
    def shuffle_targets
        if Killstory.where(game: self).count == 0
            players = self.players.shuffle
        else
            players = self.players.where.not(target_id: nil).shuffle 
        end

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
    
    def compute_stats
        SiteEvent.create(event: "Computing stats for game #{self.id}")
        self.players.each do |player|
            if player.alive?
                time_dead = Killstory.
                    where(is_kill_story: true, dead_id: self.players.map(&:id)).
                    order(:created_at).
                    last.
                    created_at + 1
            elsif Killstory.where(is_kill_story: true, dead_id: player.id).count < 1
                # for the case in which the player is taken out
                time_dead = player.updated_at
            else
                time_dead = Killstory.where(is_kill_story: true, dead_id: player.id).take.created_at
            end
            num_kills = Killstory.where(killer_id: player.id, is_kill_story: true).count
            PlayerStat.create({
                player_id: player.id,
                game_id: self.id,
                total_time_alive: time_dead - self.created_at,
                time_dead: time_dead,
                number_of_kills: num_kills,
                kill_rate_by_day: (num_kills / (time_dead - self.created_at))*(60*60*24),
            })
        end
    
    end

    def self.take_out_player(b)
        SiteEvent.create(event: "Taking out player id: #{b.id}")
        a = b.assassin
        a.target = b.target
        b.target_id = nil
        a.save
        b.save
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
