class Player < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    belongs_to :community
    has_one :target, class_name: "Player", foreign_key: "target_id"
    belongs_to :assassin, class_name: "Player"
        
    enum state: {
        dead: 0,
        alive: 1
    }
    
    def self.create_player(user, game, community)
        self.create!(community: community, game: game, user: user, state: self.states[:alive])
    end
end
