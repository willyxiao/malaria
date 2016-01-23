class WillyMailer < ApplicationMailer
    WILLY_EMAIL = 'willyxiao@gmail.com'
    MALARIA_CHALLENGE = 'malariachallenge@gmail.com'

    default from: MALARIA_CHALLENGE
    
    def community_hash_email()
        @communities = Community.all
        @communities.each do |community|
            logger.debug community
        end
        mail(to: WILLY_EMAIL, subject: "Community Hash")
    end
    
end
