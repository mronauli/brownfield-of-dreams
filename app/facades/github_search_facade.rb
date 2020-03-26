class GithubSearchFacade
  def get_repositories
    service = GithubService.new
    repository_data = service.get_repository_data[0..4]
    repository_data.map do |repo|
      Repository.new(repo)
    end
  end
end
