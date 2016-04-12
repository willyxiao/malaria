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
        fact_types_i = [:text_fact, :text_narrative].map{ |t| Malariafact.fact_types[t] }
        @fact = Malariafact.where(fact_type: fact_types_i).limit(1).order("RANDOM ()").take
        Malariafactview.create(user: @user, malariafact: @fact, shown: true)
        case @fact.fact_type
        when 'text_fact'
            @text_fact = @fact.content
            render 'api/malariafact/text_fact'
        when 'text_narrative'
            @text_narrative = @fact.content
            render 'api/malariafact/text_narrative'
        end
    end
end