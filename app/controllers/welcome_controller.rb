class WelcomeController < ApplicationController
  before_action :require_logged_out, only: [:check_hash, :register, :register_hash, :login]
  before_action :require_logged_in, only: [:index, :kill, :email]
  before_action :require_email, only: [:index]
  before_action :require_confirmed_email, only: [:kill]
  
  def index
    @user = current_user
    @player = @user.players.first
    @game = @player.nil? ? nil : @player.game

    @players_left = @game.nil? ? 
      @user.community.users.count : 
      @game.players.to_a.keep_if(&:alive?).length  
    
    @killstories = Killstory.where(game: @game, is_kill_story: true).order(created_at: :desc)
    @deathstories = Killstory.where(game: @game, is_kill_story: false).order(created_at: :desc)

    if @user.malariafactviews.where(shown: false).count > 0
      fact = @user.malariafactviews.where(shown: false).take.malariafact
      @question = fact.get_question
      render 'malariaquestion/base'
    elsif (not @player.nil?) and @player.dead?
      render 'dead'
    elsif (not @player.nil?) and @player.target == @player
      render 'win'
    end
  end

  def malaria_question_submit
    @user = current_user
    view = @user.malariafactviews.where(shown: false).take
    question = view.malariafact.get_question
  
    case question[:question_type]
    when 'multiple_choice'
      if question[:answers][params[:answer].to_i] == question[:correct]
        view.shown = true
        view.action = 'answer'
        view.save
        redirect_to root_url, flash: { message: question[:correct_text] }
      else
        redirect_to root_url, flash: { message: question[:incorrect_text] }
      end
    when 'binary'
      if (params[:answer] == '1') == question[:correct]
        view.shown = true
        view.action = 'answer'
        view.save
        redirect_to root_url, flash: { message: question[:correct_text] }
      else
        redirect_to root_url, flash: { message: question[:incorrect_text] }
      end
    end

  end
  
  def death_story
    @user = current_user
    
    @player = @user.players.take
    assassin = Killstory.where(dead: @player).take.killer
    
    if not Killstory.submit_kill(assassin, @user.players.first, false, params[:deathstory])
      throw "error!"
    end
    redirect_to root_url
  end

  def kill
    if params[:killstory].length == 0
      redirect_to root_url, flash: { message: "You have to submit a killstory" }
      return nil
    end
    
    @user = current_user
    @player = current_user.players.take

    if @player.target == @player
      throw "Player can't kill themself"
    end
      
    old_target = @player.target
    
    if not Killstory.submit_kill(@player, @player.target, true, params[:killstory])
      throw "Error in killstory"
    end
    @player.target = @player.target.target
    @player.save!
    
    viewed_question_ids = Malariafactview.
      joins(:malariafact).
      where('malariafacts.fact_type' => Malariafact.fact_types[:question]).
      order('malariafacts.id DESC').
      select('malariafacts.id')
    next_question = Malariafact.
      where(fact_type: Malariafact.fact_types[:question]).
      where.not(id: viewed_question_ids).
      order("id ASC").
      take
    if not next_question.nil?
      Malariafactview.create(user: @user, malariafact: next_question, shown: false)
    end
    
    if old_target.user.confirmed_email
      WillyMailer.you_just_died(@user, old_target).deliver_now
    end
    
    redirect_to root_url
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
  
  def login
  end
  
  def rules
    if current_user.nil?
      # pass
    elsif current_user.community.name == 'Winthrop House'
      render 'custom_rules/winthrop'
    elsif current_user.community.name == 'Eliot House'
      render 'custom_rules/eliot'
    end
  end

end
