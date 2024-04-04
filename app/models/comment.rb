class Comment < ApplicationRecord
  include ActionView::RecordIdentifier
  include Likable

  after_create_commit :broadcast_comment_creation
  after_update_commit :broadcast_comment_update
  after_destroy_commit :broadcast_comment_deletion

  belongs_to :blog_post, counter_cache: :comments_count
  belongs_to :user

  has_many :replies, class_name: '::Reply', foreign_key: 'comment_id', dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true

  private

  def broadcast_comment_creation
    broadcast_append_to 'comments'
  end

  def broadcast_comment_update
    broadcast_replace_to dom_id(self, :content), target: dom_id(self, :content), partial: 'comments/content',
                                                 locals: { comment: self }
  end

  def broadcast_comment_deletion
    broadcast_remove_to 'comments'
    broadcast_remove_to dom_id(self, :replies) if replies.any?
  end
end
