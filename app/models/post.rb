class Post < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published
    end

    event :unpublish do
      transitions from: :published, to: :draft
    end
  end

  belongs_to :user

  has_rich_text :content
  has_many :comments, dependent: :destroy, counter_cache: :comments_count

  scope :published, -> { where(state: 'published') }
  scope :draft, -> { where(state: 'draft') }

  validates :title, presence: true, length: { minimum: 5, maximum: 200 }, uniqueness: true
  validates :content, presence: true, length: { minimum: 100 }
end
