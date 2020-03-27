class GithubSearchFacade
  def get_repositories
    service = GithubService.new
    repository_data = service.get_repository_data[0..4]
    repository_data.map do |repo|
      Repository.new(repo)
    end
  end

  def get_followers
    service = GithubService.new
    follower_data = service.get_follower_data
    follower_data.map do |follower|
      Follower.new(follower)
    end
  end
end
