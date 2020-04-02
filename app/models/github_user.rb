class GithubUser
  attr_reader :email, :login

  def initialize(attributes)
    @email = attributes[:email]
    @login = attributes[:login]
  end
end
