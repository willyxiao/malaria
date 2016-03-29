class WillyMailer < ApplicationMailer
    WILLY_EMAIL = 'willyxiao@gmail.com'
    MALARIA_CHALLENGE = 'malariachallenge@gmail.com'

    default from: MALARIA_CHALLENGE
    
    def community_hash_email()
        @communities = Community.all.order(school_id: :desc)
        @admins = Admin.all.order(school_id: :desc)
        subject = Rails.env.production? ?
            "Community Hash Production" :
            "Community Hash Development"
        mail(to: WILLY_EMAIL, subject: subject)
    end
    
    def email_confirmation_email(user)
        @hash = user.email_hash
        subject = "Confirm your Malaria Assassins email"
        mail(to: user.email, subject: subject)
    end
end
