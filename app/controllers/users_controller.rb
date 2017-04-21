class UsersController < ApplicationController

  before_action :logged_in?, only: [:index, :show]

  def index
    @users = User.all
    render :index
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = "Invalid user"
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render :show
  end

  private


  def logged_in?
    redirect_to new_sessions_url unless current_user
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
