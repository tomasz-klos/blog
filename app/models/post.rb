class Post < ApplicationRecord
  belongs_to :user

  has_rich_text :content
  has_many :comments, dependent: :destroy, counter_cache: :comments_count

  validates :title, presence: true, length: { minimum: 5, maximum: 200 }, uniqueness: true
  validates :content, presence: true, length: { minimum: 100 }
end
