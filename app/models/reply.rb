class Reply < ApplicationRecord
  after_create_commit { broadcast_append_to "replies_#{comment_id}", target: "replies_#{comment_id}" }
  after_create_commit do
    broadcast_replace_to "replies_#{comment_id}_count", target: "replies_#{comment.id}_count",
                                                        partial: 'replies/replies_count', locals: { comment:, replies: comment.replies }
  end
  after_update_commit { broadcast_replace_to "replies_#{comment_id}" }
  after_destroy_commit { broadcast_remove_to "replies_#{comment_id}" }
  after_destroy_commit do
    if comment.present?
      broadcast_replace_to "replies_#{comment_id}_count", target: "replies_#{comment_id}_count",
                                                          partial: 'replies/replies_count', locals: { comment:, replies: comment.replies }
    end
  end

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_rich_text :content
  validates :content, presence: true
end
