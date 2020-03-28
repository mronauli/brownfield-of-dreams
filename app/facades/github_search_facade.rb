class GithubSearchFacade
  attr_reader :user_token

  def initialize(user_token)
    @user_token = user_token
  end

  def get_repositories
    repository_data = service.get_repository_data[0..4]
    repository_data.map do |repo|
      Repository.new(repo)
    end
  end

  def get_followers
    follower_data = service.get_follower_data
    follower_data.map do |follower|
      Follower.new(follower)
    end
  end

  def get_following
    following_data = service.get_following_data
    following_data.map do |following|
      Following.new(following)
    end
  end

private

  def service
    GithubService.new(user_token)
  end
end
