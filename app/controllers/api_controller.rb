class ApiController < ApplicationController
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
end