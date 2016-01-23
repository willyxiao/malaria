class WillyMailer < ApplicationMailer
    WILLY_EMAIL = 'willyxiao@gmail.com'
    
    def community_hash_email()
        @communities = Community.all
        mail(to: WILLY_EMAIL, subject: "Community Hash")
    end
    
end
