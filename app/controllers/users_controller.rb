class UsersController < ApplicationController
  
  before_filter :signed_in_user, only: [:edit, :update]
  
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
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
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
  
  private

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end  
end
