class SessionsController < ApplicationController

  skip_before_filter :authenticate, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username], params[:user][:password])

    if @user
      login(@user)
      redirect_to users_url
    else
      flash.now[:errors] = ["Invalid Username/Password Combination"]
      render :new
    end
  end

  def destroy
    @user = current_user
    @user.reset_token
    session[:token] = nil
    render :new
  end

end
