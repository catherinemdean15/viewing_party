class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = 'You signed up successfully'
      user.update(is_registered?: true)
      redirect_to dashboard_user_path(user)
    else
      flash.now[:errors] = user.errors.full_messages
      render 'new'
    end
  end

  def dashboard
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
