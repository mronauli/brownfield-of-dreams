# frozen_string_literal: true

class Following
  attr_reader :login, :html_url, :github_id

  def initialize(attributes)
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @github_id = attributes[:id]
  end

  def find_by_id
    User.exists?(github_id: github_id)
  end
end
