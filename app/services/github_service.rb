class GithubService

  def get_repository_data
    response = conn.get("/user/repos")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  def get_follower_data
    response = conn.get("/user/followers")
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.github.com") do |f|
      f.headers["Authorization"] = ENV['GITHUB_ACCESS_TOKEN_2']
      f.adapter Faraday.default_adapter
    end
  end
end
