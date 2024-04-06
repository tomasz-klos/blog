class Reply < ApplicationRecord
  include Likable

  belongs_to :user
  belongs_to :comment, class_name: 'Comment', foreign_key: 'comment_id'

  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true
end
