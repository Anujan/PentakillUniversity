class UserController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :students, :mentors]
  
  def verify
    @user = current_user
    unless (@user.summoner_verified?)
     result = @user.summoner_verify
     if (result)
       flash[:notice] = 'Your summoner has now been verified!'
     else
       flash[:error] = 'Your verification was unsuccessful. Please try again.'
     end
    end
    redirect_to root_path
  end

  def show
    @user = User.find(params[:id])
  end

  def requests
    @user = current_user
    @requests = @user.requests
  end

  def request_mentorship
    @requester = current_user
    @requestee = Student.find(params[:id])
  end

  def applications
    @user = current_user
    @app = @user.apps
  end
  
  def apply
    @student = current_user
    @mentor = Mentor.find(params[:id])
  end
  
  def students
    @users = Student.where(:verify_code => 'VERIFIED')
  end

  def mentors
    @user = Mentor.where(:verify_code => 'VERIFIED')
  end

  def profile
    @user = current_user
  end
end
