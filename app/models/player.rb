class Player < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    belongs_to :community
    has_one :target, class_name: "Player", foreign_key: "target_id"
    belongs_to :assassin, class_name: "Player"

    def self.create_player(user, game, community)
        self.create!(community: community, game: game, user: user)
    end
    
    def dead?
        Killstory.where(game: self.game, dead: self.id).count > 0
    end
    
    def alive?
        not self.dead?
    end
end
