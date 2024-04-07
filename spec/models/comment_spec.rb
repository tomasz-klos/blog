require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe('associations') do
    it { should belong_to(:post).counter_cache(:comments_count) }
    it { should belong_to(:user) }
    it { should have_many(:replies).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe('validations') do
    it { should validate_presence_of(:content) }
  end
end
