class User < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  friendly_id :name, use: [:slugged, :finders]

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }, uniqueness: true

  has_one_attached :avatar
end
