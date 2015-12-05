class Player < ActiveRecord::Base
    belongs_to :game
    belongs_to :user
    has_one :player
    
    enum state: {
        dead: 0,
        alive: 1
    }
end
