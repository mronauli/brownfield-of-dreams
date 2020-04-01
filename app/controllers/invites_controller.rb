class InvitesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    service = GithubService.new(current_user.token)
    #current_user, email
    service.get_user(params[:github_handle])
    require "pry"; binding.pry
    redirect_to dashboard_path
  end
end
