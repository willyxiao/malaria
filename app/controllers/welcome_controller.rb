class WelcomeController < ApplicationController
<<<<<<< HEAD
  def index
    if not current_user.nil?
      redirect_to dashboard_url
    end
  end

=======
  
  def index
  end
  
>>>>>>> f1b1625c5bbefaa42425c7e4ff27d71d30e10d90
  def dashboard
    # assign current logged in user to user to track quiz score
    @user = current_user
  end
  
  def rules
  end
  
  def facts
  end
  
  def get_involved
  end
  
  def about
  end
  
  def quiz
  end
  
  def grade_quiz
    puts "GRADING QUIZ"
    @correct = [3,3,2,3,1]
    @answers = params[:quiz]
    $count = 0
    if @answers["q1"] == "3"
      $count += 1;
    end
    if @answers["q2"] == "3"
      $count += 1;
    end
    if @answers["q3"] == "2"
      $count += 1;
    end
    if @answers["q4"] == "3"
      $count += 1;
    end
    if @answers["q5"] == "1"
      $count += 1;
    end
    puts $count
    @user = current_user
    @user.quizscore = $count
    @user.save!
    redirect_to dashboard_url
  end
end
