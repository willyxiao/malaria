class AdminController < ApplicationController
    def login_page
        if get_admin
            redirect_to action: "dashboard"
        end
    end
    
    def login
        params.permit(:email, :password)
        @admin = Admin.find_by_email(params[:email])
        if @admin && @admin.password == params[:password]
            session[:admin_id] = @admin.id
            redirect_to admin_url
        else
            redirect_to admin_login_url
        end
    end

    def dashboard
        @admin = get_admin
        if @admin.nil?
            redirect_to admin_login_url
        end
        
        @users = @admin.school.communities.map(&:users).flatten.uniq
        @users.sort_by(&:community_id)
    end
    
    private 
    
    def get_admin
        session[:admin_id] ? Admin.find(session[:admin_id]) : nil
    end

end
