class InvitesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    service = GithubService.new(current_user.token)
    service.get_user(params[:github_handle])
    redirect_to dashboard_path
  end
end
