class UsersController < ApplicationController
  before_action :set_current_user, only: [ :edit, :show , :destroy]
  #before_action :set_current_user, only: [:new, :edit, :show , :destroy]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def set_current_user
    unless logged_in?
    flash[:warning] = 'ログインして下さい'
    redirect_to new_session_path
    end
  end
end
