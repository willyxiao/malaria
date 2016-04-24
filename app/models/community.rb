class Community < ActiveRecord::Base
    has_one :game
    belongs_to :school
    has_many :users
    has_many :players

    def create_game(duplicate = false)
        if !self.game.nil?
            throw "Game already created"
        end
        
        game = Game.create_game(self)
        self.users.each do |user|
            Player.create!(game: game, user: user, community: self)
        end
        game.shuffle_targets
    end

    def self.create_new(name, school_id)
        self.create!({ 
            name: name, 
            school_id: school_id, 
            hash1: self.random_string(),
            hash2: self.random_string(),
            hash3: self.random_string(),
        })
    end
    
    private 
    
    def self.random_string(length=4)
        chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ0123456789'
        password = ''
        length.times { password << chars[rand(chars.size)] }
        password
    end
end
