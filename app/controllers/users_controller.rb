class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
    
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      #
    else
      render 'edit'
    end
  end
  
  def create
    @user = User.create(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the sample app"
      redirect_to user_path(@user)
    else
      render :new    
    end
  end 
end
