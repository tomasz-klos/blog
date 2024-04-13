class Post < ApplicationRecord
  include AASM

  aasm column: 'state' do
    state :draft, initial: true
    state :published

    event :publish do
      transitions from: :draft, to: :published, guard: :can_publish?
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

  private

  def can_publish?
    content.present? && title.present?
  end
end
