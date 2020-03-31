class FriendshipsController < ApplicationController
  def create
    friend = User.find_by_github_id(params[:github_id])
    if !friend.nil? && friend != current_user
      Friendship.create(user: current_user, friend: friend)
      current_user.reload
      flash[:success] = "Friend added!"
    else
      flash.now[:notice] = "Sorry, that's an invalid ID!"
    end
    redirect_to dashboard_path
  end
end
