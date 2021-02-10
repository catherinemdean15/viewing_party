class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if matching_password? && user.save
      UserMailer.welcome_email(user).deliver_now
      flash[:notice] = 'You signed up successfully'
      session[:user_id] = user.id
      redirect_to dashboard_user_path(user)
    else
      flash[:notice] = if !matching_password?
                         'Passwords do not match'
                       else
                         'Please fill in both an email and a password'
                       end
      redirect_to registration_path
    end
  end

  def dashboard
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def matching_password?
    params[:user][:password] == params[:user][:password_confirmation]
  end
end
