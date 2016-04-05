class Player < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    belongs_to :community
    has_one :target, class_name: "Player", foreign_key: "target_id"
    belongs_to :assassin, class_name: "Player"
    
    has_many :killstories

    KILL_PAUSE = 5

    def self.create_player(user, game, community)
        self.create!(community: community, game: game, user: user)
    end
    
    def dead?
        (Killstory.where(game: self.game, dead_id: self.id).count > 0) 
        # and 
        # KILL_PAUSE < ((Time.now - Killstory.where(game: self.game, dead_id: self.id).take.) / 60)
    end
    
    def alive?
        not self.dead?
    end
    
    def paused_time?
        false
        # self.killstories.where > 0 and 
        # KILL_PAUSE < ((Time.now - self.killstory) / 60)
    end
end
