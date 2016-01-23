class WillyMailer < ApplicationMailer
    WILLY_EMAIL = 'willyxiao@gmail.com'
    MALARIA_CHALLENGE = 'malariachallenge@gmail.com'

    default from: MALARIA_CHALLENGE
    
    def community_hash_email()
        @communities = Community.all
        @communities.each do |community|
            logger.debug community
        end
        subject = Rails.env.production? ?
            "Community Hash Production" :
            "Community Hash Development"
            
        mail(to: WILLY_EMAIL, subject: subject)
    end
    
end
