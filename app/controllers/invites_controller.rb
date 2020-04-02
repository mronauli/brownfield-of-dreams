class InvitesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    handle = params[:github_handle]
    service = GithubService.new(current_user.token)
    data = service.get_github_user_data(handle)
    github_friend = GithubUser.new(data)
    if !data[:email].nil?
      FriendInviteMailer.github_invite(current_user, github_friend).deliver
      flash[:success] = "Successfully sent invite!"
    else
      flash[:error] = "The Github user you selected doesn't have an email address associated with their account."
    end
    redirect_to dashboard_path
  end
end
