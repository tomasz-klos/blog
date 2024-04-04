class Reply < ApplicationRecord
  include ActionView::RecordIdentifier
  include Likable

  after_create_commit { broadcast_append_to dom_id(comment, :replies), target: dom_id(comment, :replies) }
  after_create_commit do
    broadcast_replace_to dom_id(comment, :replies_count), target: dom_id(comment, :replies_count),
                                                          partial: 'replies/replies_count',
                                                          locals: { comment:, replies: comment.replies }
  end
  after_update_commit { broadcast_replace_to dom_id(comment, :replies) }
  after_destroy_commit { broadcast_remove_to dom_id(comment, :replies) }
  after_destroy_commit do
    if comment.present?
      broadcast_replace_to dom_id(comment, :replies_count),
                           target: dom_id(comment, :replies_count),
                           partial: 'replies/replies_count',
                           locals: { comment:, replies: comment.replies }
    end
  end

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true
end
