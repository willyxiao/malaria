class Killstory < ActiveRecord::Base
    belongs_to :game
    belongs_to :killer, class_name: 'Player', foreign_key: 'killer_id'
    belongs_to :dead, class_name: 'Player', foreign_key: 'dead_id'

    def self.submit_kill(killer, dead, is_kill_story, story)
        if killer.game.id != dead.game.id
            throw "Killer and Dead must be playing in the same game"
        elsif killer.dead? or dead.dead?
            throw "Either your killer or the dead person is already dead, no new killstories"
        end
        
        self.create!(game: killer.game, killer: killer, dead: dead, is_kill_story: is_kill_story, story: story)
    end
end