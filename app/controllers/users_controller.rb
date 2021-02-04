class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = 'You signed up successfully'
      # user.update_columns(:is_registered? => true)
      user.update(is_registered?: true)
      redirect_to root_path
    else
      flash.now[:errors] = user.errors.full_messages
      render 'new'
    end
  end

  def dashboard; end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
