class CheersController < ApplicationController

  def create
    params[:cheer] = {}
    params[:cheer][:user_id] = current_user.id
    params[:cheer][:goal_id] = params[:goal_id]
    cheer = Cheer.new(params[:cheer])

    if cheer.save
      redirect_to user_url(cheer.goal.user)
    else
      flash[:errors] = cheer.errors.full_messages
      redirect_to user_url(cheer.goal.user)
    end
  end

end
