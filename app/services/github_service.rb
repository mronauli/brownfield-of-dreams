class GithubService
  attr_reader :user_token

  def initialize(user_token)
    @user_token = user_token
  end

  def get_repository_data
    get_url("repos")
  end

  def get_follower_data
    get_url("followers")
  end

  def get_following_data
    get_url("following")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{user_token}"
      f.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = conn.get("/user/#{url}")
    JSON.parse(response.body, symbolize_names: true)
  end
end
