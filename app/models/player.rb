class Player < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    belongs_to :community
    has_one :target, class_name: "Player", foreign_key: "target_id"
    # belongs_to :assassin, class_name: "Player"
    
    has_many :killstories

    def self.create_player(user, game, community)
        self.create!(community: community, game: game, user: user)
    end
    
    def dead?
        (Killstory.where(game: self.game, dead_id: self.id).count > 0) 
    end
    
    def alive?
        not self.dead?
    end
    
    def kill_player_debug
        Killstory.submit_kill(self.assassin, self, true, "Debug")
        a = self.assassin
        a.target = self.target
        a.save
    end
    
    def paused_time?
        false
    end
    
    def submitted_death?
        (Killstory.where(is_kill_story: false, dead_id: self.id).count > 0)
    end
    
    def death_story
        Killstory.where(is_kill_story: false, dead_id: self.id).take
    end
    
    def assassin
        Player.where(target_id: self.id).take
    end
end
