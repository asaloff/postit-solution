class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash["notice"] = "You are now registered"
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash['notice'] = "You've updated your information"
      redirect_to root_path
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find(params[:id])
  end

  def require_same_user
    if current_user != @user 
      flash["error"] = "You do not have permissions to do that."
      redirect_to root_path
    end
  end
end

