class Reply < ApplicationRecord
  include Likable

  after_create_commit { broadcast_append_to_replies }
  after_update_commit { broadcast_replace_to_replies }
  after_destroy_commit { broadcast_remove_to_replies }

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true

  private

  def broadcast_append_to_replies
    broadcast_append_to "replies_#{comment_id}", target: "replies_#{comment_id}",
                                                 partial: 'replies/reply',
                                                 locals: { reply: self, current_user: Current.user }

    broadcast_replace_to "replies_#{comment_id}_count", target: "replies_#{comment_id}_count",
                                                        partial: 'replies/replies_count',
                                                        locals: { comment:, replies: comment.replies }
  end

  def broadcast_replace_to_replies
    broadcast_replace_to "replies_#{comment_id}", target: "reply_#{id}",
                                                  partial: 'replies/reply',
                                                  locals: { reply: self, current_user: Current.user }
  end

  def broadcast_remove_to_replies
    broadcast_remove_to "replies_#{comment_id}", target: "reply_#{id}"

    return unless comment.present?

    broadcast_replace_to "replies_#{comment_id}_count", target: "replies_#{comment_id}_count",
                                                        partial: 'replies/replies_count',
                                                        locals: { comment:, replies: comment.replies }
  end
end
