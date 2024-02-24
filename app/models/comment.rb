class Comment < ApplicationRecord
  belongs_to :blog_post, counter_cache: :comments_count 
  belongs_to :parent_comment, class_name: "Comment", optional: true
  belongs_to :user
  
  has_many :replies, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy

  has_rich_text :content
  validates :content, presence: true
end