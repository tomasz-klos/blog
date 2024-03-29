class BlogPost < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_many :comments, dependent: :destroy, counter_cache: :comments_count

  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :content, presence: true
end
