class WelcomeController < ApplicationController
  before_action :require_no_login, only: [:index, :signup]
  
  def index
  end

  def register
  end

  def check_hash
    communities = Community.where(hash1: params[:hash])
    render json:  if communities.empty?
                    session.delete :community_id
                    {
                      success: false,
                      error: "#{ params[:hash] } was not found"
                    }
                  else
                    community = communities.first
                    session[:community_id] = community.id
                    {
                      success: true,
                      community: {
                        id: community.id,
                        name: community.name,
                        school: {
                          id: community.school.id,
                          name: community.school.name,
                        }
                        # admin: {
                          
                        #   email: community.school.admin.email
                        # }
                      }
                    }
                  end
  end
  
  def register_hash
    redirect_to register_url + "#/#{ params[:hash] }"
  end
  
  def dashboard
  end
  
  def rules
  end

  private
  
  def require_no_login
    if not current_user.nil?
      redirect_to dashboard_url
    end
  end
end
