class GoalsController < ApplicationController

  def new
    @goal = Goal.new
  end

  def create
    params[:goal][:user_id] = current_user.id
    @goal = Goal.new(params[:goal])

    if @goal.save
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(params[:goal])
      redirect_to current_user
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def destroy
    Goal.destroy(params[:id])
    redirect_to current_user
  end
end
