class Comment < ApplicationRecord
  include Likable

  belongs_to :post, counter_cache: :comments_count
  belongs_to :user

  has_many :replies, class_name: '::Reply', foreign_key: 'comment_id', dependent: :destroy
  has_many :likes, as: :likable, dependent: :destroy

  has_rich_text :content
  validates :content, presence: true
end
