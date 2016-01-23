class User < ActiveRecord::Base
    has_many :players
    belongs_to :community
    # has_and_belongs_to_many :friends, 
    #     class_name: "User", 
    #     join_table: :friends, 
    #     foreign_key: :user_id, 
    #     association_foreign_key: :friend_user_id
    
    def self.find_registered(id)
        user = self.find(id)
        user.community.nil? ? nil : user
    end
    
    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.image = auth.info.image
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.save!
      end
    end
end
