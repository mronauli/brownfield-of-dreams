# rubocop:todo Style/Documentation
# frozen_string_literal: true

class AddGithubIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :github_id, :string
  end
end
# rubocop:enable Style/Documentation
