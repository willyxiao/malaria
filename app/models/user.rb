class User < ActiveRecord::Base
    has_many :players
    belongs_to :community
    has_many :malariafactviews
    
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
    
    def self.valid_email?(email)
        not (/^[A-Z0-9._%a-z\-]+@(?:[A-Z0-9a-z\-\.]+)+\.edu$/ =~ email).nil?
    end
    
    def self.email_in_use?(email)
        not self.where(email: email, confirmed_email: true).empty?
    end
    
    def self.print_emails(users)
        users.each do |user|
            if user.confirmed_email
                puts "#{user.email},"
            end
        end
    end
    
    def save_unconfirmed_email(email)
        if not User.valid_email?(email)
            throw :save_error, "Invalid email #{email}, must end in .edu"
        elsif User.email_in_use?(email)
            throw :save_error, "Email #{email} is already being used"
        end

        self.email = email
        self.confirmed_email = false
        self.email_hash = Community.random_string()
        self.save!
    end
    
end
