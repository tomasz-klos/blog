class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true

  validates :user_id, uniqueness: { scope: %i[likable_type likable_id], message: 'You can only like once' }
end
