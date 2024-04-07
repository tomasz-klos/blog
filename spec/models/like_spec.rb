require 'rails_helper'

RSpec.describe Like, type: :model do
  describe('associations') do
    it { should belong_to(:user) }
    it { should belong_to(:likable) }
  end

  describe('validations') do
    it('validates uniqueness of user within the scope of likable_type and likable_id for comments') do
      user = FactoryBot.create(:user)
      comment = FactoryBot.create(:comment)
      FactoryBot.create(:like, user:, likable: comment)

      like = FactoryBot.build(:like, user:, likable: comment)
      like.valid?
      expect(like.errors[:user_id]).to include('You can only like once')
    end

    it('validates uniqueness of user within the scope of likable_type and likable_id for replies') do
      user = FactoryBot.create(:user)
      reply = FactoryBot.create(:reply)
      FactoryBot.create(:like, user:, likable: reply)

      like = FactoryBot.build(:like, user:, likable: reply)
      like.valid?
      expect(like.errors[:user_id]).to include('You can only like once')
    end
  end

  describe('factory') do
    it('is valid') do
      like = FactoryBot.build(:like)
      expect(like).to be_valid
    end
  end
end
