class WillyMailer < ApplicationMailer
    WILLY_EMAIL = 'willyxiao@gmail.com'

    default from: WILLY_EMAIL
    
    def community_hash_email()
        @communities = Community.all
        @communities.each do |community|
            logger.debug community
        end
        mail(to: WILLY_EMAIL, subject: "Community Hash")
    end
    
end
