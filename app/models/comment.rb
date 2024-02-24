class Comment < ApplicationRecord
  after_create_commit { broadcast_prepend_to 'comments' }
  after_update_commit { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to 'comments' }

  belongs_to :blog_post, counter_cache: :comments_count
  belongs_to :parent_comment, class_name: 'Comment', optional: true
  belongs_to :user

  has_many :replies, class_name: 'Comment', foreign_key: 'parent_comment_id', dependent: :destroy

  has_rich_text :content
  validates :content, presence: true
end
