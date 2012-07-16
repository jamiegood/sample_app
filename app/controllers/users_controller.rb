class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      flash[:success] = "Welcome to the sample app"
      redirect_to user_path(@user)
    else
      render :new    
    end
  end 
end
