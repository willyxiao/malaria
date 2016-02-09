class ApiController < ApplicationController
    def user
        render json: {
            id: current_user.id,
            name: current_user.name,
            email: current_user.email,
            confirmed_email: current_user.confirmed_email,
            image: current_user.image,
        }
    end
end