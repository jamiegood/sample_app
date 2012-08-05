class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by_email(params[:session][:email])
    if user && user.authenicate(params[:session][:password])
      # successful sign up
    else
      flash[:error] = 'Invalid email/password combination'
      render 'new'
    end
    
  end
  
  def destroy
  end
  
end
