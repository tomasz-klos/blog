class Comment < ApplicationRecord
  include Likable
  after_create_commit { broadcast_append_to 'comments' }
  after_update_commit { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to 'comments' }

  belongs_to :blog_post, counter_cache: :comments_count
  belongs_to :user

  has_many :replies, class_name: '::Reply', foreign_key: 'comment_id', dependent: :destroy
  has_many :likes, as: :likable

  has_rich_text :content
  validates :content, presence: true

  def liked_by?(user)
    likes.exists?(user:)
  end
end
