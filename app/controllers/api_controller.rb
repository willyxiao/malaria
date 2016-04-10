class ApiController < ApplicationController
    layout false
    
    def user
        render json: {
            id: current_user.id,
            uid: current_user.uid,
            name: current_user.name,
            email: current_user.email,
            confirmed_email: current_user.confirmed_email,
            image: current_user.image,
            community: current_user.community.name,
            school: current_user.community.school.name,
        }
    end
    
    def malaria_fact
        @user = current_user
        @fact = Malariafact.where(fact_type: Malariafact.fact_types[:text_fact]).limit(1).order("RANDOM ()")
        Malariafactview.create(user: @user, malariafact: fact, shown: true)
        render 'malariafact/text_fact'
    end
end