class UsersController < ApplicationController
  def show
    repository_data = get_repository_data
    @repositories = get_repository_data.map do |repo|
      Repository.new(repo)
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.create(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      flash[:error] = 'Username already exists'
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end

  def get_repository_data
    conn = Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = ENV['GITHUB_ACCESS_TOKEN']
      f.adapter Faraday.default_adapter
    end

    response = conn.get("/user/repos")
    json = JSON.parse(response.body, symbolize_names: true)
    return json[0..4]
  end
end
