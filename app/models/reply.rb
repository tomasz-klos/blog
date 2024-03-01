class Reply < ApplicationRecord
  after_create_commit { broadcast_append_to "replies_#{comment_id}", target: "replies_#{comment_id}",  locals: { replies_count: comment.replies.count } }
  after_update_commit { broadcast_replace_to "replies_#{comment_id}", target: "replies_#{comment_id}" }
  after_destroy_commit { broadcast_remove_to "replies_#{comment_id}" }

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_rich_text :content
  validates :content, presence: true
end
