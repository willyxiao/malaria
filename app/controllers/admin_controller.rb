class AdminController < ApplicationController
    before_action :require_admin, except: [:login_page, :login]
    
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

    def logout
        session[:admin_id] = nil
        redirect_to root_url
    end

    def dashboard
        @admin = get_admin
        if @admin.nil?
            redirect_to admin_login_url
        end
        
        @users = @admin.school.communities.map(&:users).flatten.uniq
        @users.sort_by(&:community_id)
    end
    
    def community
        @admin = get_admin
        @community = Community.find(params[:community_id])
        @users = @community.users.to_a
        
        if Game.where(community_id: @community.id).count == 0
            render 'community'
        else
            @game = Game.where(community_id: @community.id).first
            @dead_players = @game.players.to_a.keep_if(&:dead?).map(&:user)

            alive_players_by_id = @game.
                players.to_a.keep_if(&:alive?).group_by(&:id)
            first = alive_players_by_id.values.first.first
            current = alive_players_by_id[first.target_id].first
            
            @alive_players = [first.user]
            while first.id != current.id
                @alive_players.push(current.user)
                current = alive_players_by_id[current.target_id].first
            end
            
            @users = nil
            
            render 'game'
        end
    end
    
    def start_game
        if (not super_admin?) and (not admin_controls_community?(params[:community_id], get_admin))
            raise "Error admin not tied to community"
        end
        community = Community.find(params[:community_id])
        Game.create_game(community)
        WillyMailer.game_begins_to_players(community).deliver_now
        WillyMailer.game_begins_to_willy(community).deliver_now
        redirect_to :admin_community
    end
    
    def stats
        @admin = get_admin
        if @admin.email != 'willyxiao@gmail.com'
            redirect_to admin_url
        end

        @stats = {
          users: User.count,
          active: Player.count,
          alive: Player.where.not(target_id: nil).count,
          communities: Community.count - 2, # there are two test houses
          malariafactviews: Malariafactview.count,
          questions: Malariafactview.joins(:malariafact).where('malariafacts.fact_type': Malariafact.fact_types[:question]).count,
        }
        
        @last_kill = Killstory.where(is_kill_story: true).order('created_at DESC').first
        
        @users = User.all
        @communities = Community.all.order('school_id DESC').map do |community|
            game_started = (not community.game.nil?)
            deaths = game_started ? Player.where(community: community, target_id: nil).count : 0
            {
                school: community.school.name,
                name: community.name,
                registered: User.where(community: community).count,
                game_started: game_started,
                game_start: game_started ? time_str(community.game.created_at) : 'N/A',
                last_kill: (game_started and deaths > 0) ? (Killstory.where(game_id: community.game.id, is_kill_story: true).order("created_at DESC").first.created_at) : 'N/A',
                players: Player.where(community: community).count,
                deaths: deaths,
            }
        end
    end
    
    private 
    
    def get_admin
        session[:admin_id] ? Admin.find(session[:admin_id]) : nil
    end
    
    def require_admin
        if not session[:admin_id]
            redirect_to :admin_login
        end
    end
    
    def super_admin?
        (get_admin).email == 'willyxiao@gmail.com'
    end
    
    def admin_controls_community?(community_id, admin)
        Community.find(community_id).school.id == admin.school.id
    end
    
    def time_str(time,zone='EST')
        time.in_time_zone(zone).strftime("%m/%d/%y %H:%M:%S")
    end
end
