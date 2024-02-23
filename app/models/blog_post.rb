class BlogPost < ApplicationRecord
  belongs_to :user

  has_rich_text :content

  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :content, presence: true, length: { minimum: 10 }
end
