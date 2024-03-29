class UsersController < ApplicationController

  skip_before_filter :authenticate, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      login(@user)
      redirect_to users_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

end
