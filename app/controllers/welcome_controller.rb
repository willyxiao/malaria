class WelcomeController < ApplicationController
  before_action :require_logged_out, only: [:check_hash, :register, :register_hash, :login]
  before_action :require_logged_in, only: [:index]
  before_action :require_email, only: [:index]
  
  def index
  end

  def email
    @current_user = current_user
  end

  def email_confirm
    if User.email_in_use?(current_user.email)
      redirect_to email_url, flash: { message: "Email #{current_user.email} already in use, please use another" }
    elsif params[:hash] == current_user.email_hash
      current_user.confirmed_email = true
      current_user.save!
      redirect_to root_url, flash: { message: "Successfully confirmed email." }
    else
      redirect_to email_url, flash: { message: "Hash #{params[:hash]} incorrect" }
    end
  end
  
  def email_submit
    if params[:email]
      begin
        current_user.save_unconfirmed_email(params[:email])
        WillyMailer.email_confirmation_email(current_user).deliver_now
        redirect_to root_url, flash: { message: "Check your email to confirm" }
      rescue => ex
        redirect_to email_url, flash: { message: "Email either in use or invalid, please try again" }
      end
    else
      redirect_to email_url, flash: { message: "Enter an email" }
    end
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
                      }
                    }
                  end
  end
  
  def register_hash
    redirect_to register_url + "#/#{ params[:hash] }"
  end
  
  def dashboard
  end
  
  def login
  end
  
  def rules
  end

end
