class BlogPost < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }, uniqueness: true
  validates :body, presence: true, length: { minimum: 10 }

  belongs_to :user
end
