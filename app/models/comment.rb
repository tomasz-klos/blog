class Comment < ApplicationRecord
  include Likable

  after_create_commit { broadcast_append_to 'comments' }
  after_update_commit { broadcast_replace_to 'comments' }
  after_destroy_commit { broadcast_remove_to 'comments' }

  belongs_to :blog_post, counter_cache: :comments_count
  belongs_to :user

  has_many :replies, class_name: '::Reply', foreign_key: 'comment_id', dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true

  private

  def broadcast_append_to_comments
    broadcast_append_to 'comments', target: 'comments',
                                    partial: 'comments/comment',
                                    locals: { comment: self, user: }
  end

  def broadcast_replace_to_comments
    broadcast_replace_to 'comments', target: "comment_#{id}",
                                     partial: 'comments/comment',
                                     locals: { comment: self, user: }
  end

  def broadcast_remove_to_comments
    broadcast_remove_to 'comments', target: "comment_#{id}"
  end
end
