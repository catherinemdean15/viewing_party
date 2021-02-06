class FriendsController < ApplicationController
  def create
    new_friend = User.find_by(email: friend_params[:email])
    if new_friend
      Friend.create!(friend1_id: params[:user_id], friend2_id: new_friend.id)
      flash[:notice] = "You have added #{new_friend.email} as a friend"
    else
      flash[:notice] = 'Please enter valid email address'
    end
    redirect_to dashboard_user_path(current_user)
  end

  private

  def friend_params
    params.require(:friend).permit(:email)
  end
end
