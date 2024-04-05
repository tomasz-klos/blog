class Reply < ApplicationRecord
  include ActionView::RecordIdentifier
  include Likable

  after_create_commit :broadcast_reply_creation
  after_update_commit :broadcast_reply_update
  after_destroy_commit :broadcast_reply_deletion

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true

  private

  def broadcast_reply_creation
    broadcast_append_to dom_id(comment, :replies), target: dom_id(comment, :replies)
    broadcast_replace_to dom_id(comment, :replies_count), target: dom_id(comment, :replies_count),
                                                          partial: 'replies/replies_count',
                                                          locals: { comment:, replies: comment.replies }
  end

  def broadcast_reply_update
    return unless comment.replies.any?

    broadcast_replace_to dom_id(comment, :replies)
  end

  def broadcast_reply_deletion
    return unless comment.present?

    broadcast_remove_to dom_id(comment, :replies)
    return unless comment.replies.any?

    broadcast_replace_to dom_id(comment, :replies_count),
                         target: dom_id(comment, :replies_count),
                         partial: 'replies/replies_count',
                         locals: { comment:, replies: comment.replies }
  end
end
