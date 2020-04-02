# frozen_string_literal: true

class GithubSearchFacade
  attr_reader :user_token

  def initialize(user_token)
    @user_token = user_token
  end

  def repository_data
    service.get_repository_data[0..4]
  end

  def follower_data
    service.get_follower_data
  end

  def following_data
    service.get_following_data
  end

  def get_repositories # rubocop:todo Naming/AccessorMethodName
    repository_data.map do |repo|
      Repository.new(repo)
    end
  end

  def get_followers # rubocop:todo Naming/AccessorMethodName
    follower_data.map do |follower|
      Follower.new(follower)
    end
  end

  def get_following # rubocop:todo Naming/AccessorMethodName
    following_data.map do |following|
      Following.new(following)
    end
  end

  private

  def service
    GithubService.new(user_token)
  end
end
