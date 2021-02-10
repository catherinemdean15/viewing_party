class SessionsController < ApplicationController
  def new
    redirect_to dashboard_user_path(current_user), notice: 'You are already logged in!' if current_user
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_user_path(user), notice: 'You are logged in!'
    else
      flash.now[:alert] = 'Invalid login email, or password'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'You are logged out'
  end
end
