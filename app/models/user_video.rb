# frozen_string_literal: true

class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: 'video_id'
  belongs_to :user, foreign_key: 'user_id'
  has_many :tutorials, through: :video

  def self.order_bookmarked(user_id)
    User.find_by_id(user_id)
        .videos.joins(:tutorial)
        .order('tutorials.id')
        .order('videos.position')
  end
end
