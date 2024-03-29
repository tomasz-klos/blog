module Likable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likable, dependent: :destroy
  end

  def toggle_like(user)
    like = likes.find_by(user:)
    if like
      like.destroy
    else
      likes.create(user:)
    end
  end

  def liked_by_user?(user)
    likes.exists?(user:)
  end
end
