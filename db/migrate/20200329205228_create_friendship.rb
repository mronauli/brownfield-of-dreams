# rubocop:todo Style/Documentation
# frozen_string_literal: true

class CreateFriendship < ActiveRecord::Migration[5.2]
  def change
    create_table :friendships do |t|
      t.references :user, foreign_key: true
      t.references :friend

      t.timestamps
    end
  end
end
# rubocop:enable Style/Documentation
