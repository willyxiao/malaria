class Admin < ActiveRecord::Base
    belongs_to :school

    def password
        self.password_hash
    end
    
    def password=(password)
        self.password_hash = password
    end
end
