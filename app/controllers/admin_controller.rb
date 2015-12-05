class AdminController < ApplicationController
    def login_page
        if get_admin
            redirect_to action: "dashboard"
        end
    end
    
    def login
        @admin = Admin.find_by_email(params[:email])
        if @admin.password == params[:password]
            session[:admin_id] = @admin.id
            redirect_to action: "dashboard"
        else
            redirect_to "login"
        end
    end

    def dashboard
        @admin = get_admin
        if @admin.nil?
            redirect_to action: "login"
        end
    end
    
    private 
    
    def get_admin
        session[:admin_id] ? Admin.find(session[:admin_id]) : nil
    end

    def hash
    end
end
