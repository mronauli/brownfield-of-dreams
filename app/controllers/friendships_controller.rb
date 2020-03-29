class FriendshipsController < ApplicationController
  def create
    require "pry"; binding.pry
    if params.include?(:friend_id)
      @new_friendships = Friendship.create_reciprocal_for_ids(current_user_id, params[:friend_id])
    else
      params[:user][:friend_ids].each do |friend_id|
        require "pry"; binding.pry
        @new_friendships = Friendship.create_reciprocal_for_ids(current_user_id, friend_id)
      end
    end
    redirect_to dashboard_path
  end

  def destroy
    Friendship.destroy_reciprocal_for_ids(current_user_id, params[:friend_id])
    redirect_to dashboard_path
  end
end
