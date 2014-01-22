module SessionsHelper

  def current_user
    return nil unless session[:token]
    @current_user ||= User.find_by_token(session[:token])
  end

  def login(user)
    session[:token] = user.reset_token
  end

  def authenticate
    redirect_to new_session_url unless current_user
  end

end
