class GithubService
  attr_reader :user_token

  def initialize(user_token)
    @user_token = user_token
  end

  def get_repository_data
    response = conn.get("/user/repos")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def get_follower_data
    response = conn.get("/user/followers")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def get_following_data
    response = conn.get("/user/following")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{user_token}"
      f.adapter Faraday.default_adapter
    end
  end
end
