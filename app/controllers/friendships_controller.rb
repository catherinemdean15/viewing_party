class FriendshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    friend = User.find_by(email: params[:email])
    if friend 
      friendship = Friendship.create(user: user, friend_id: friend.id)
      flash[:notice] = "You have added #{friend.email} as a friend"
      redirect_to dashboard_user_path(user)
    else
      flash[:notice] = "Please enter valid email address"
      redirect_to dashboard_user_path(user)
    end
  end
end