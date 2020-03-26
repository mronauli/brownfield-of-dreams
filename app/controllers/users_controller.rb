class UsersController < ApplicationController
  def show
    response = Faraday.get("https://api.github.com/user/repos", {visibility: "all"}, {Authorization: ENV['GITHUB_ACCESS_TOKEN']})
    # JSON.parse(response.body)
    # response = Faraday.new
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

end
