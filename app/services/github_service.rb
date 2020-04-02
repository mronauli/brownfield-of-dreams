class GithubService
  attr_reader :user_token

  def initialize(user_token)
    @user_token = user_token
  end

  def get_repository_data # rubocop:todo Naming/AccessorMethodName
    get_url("/user/repos")
  end

  def get_follower_data # rubocop:todo Naming/AccessorMethodName
    get_url("/user/followers")
  end

  def get_following_data # rubocop:todo Naming/AccessorMethodName
    get_url("/user/following")
  end

  def get_github_user_data(handle)
    get_url("/users/#{handle}")
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = "token #{user_token}"
      f.adapter Faraday.default_adapter
    end
  end

  def get_url(url)
    response = conn.get(url.to_s)
    JSON.parse(response.body, symbolize_names: true)
  end
end
