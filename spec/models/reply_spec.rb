require 'rails_helper'

RSpec.describe Reply, type: :model do
  describe('associations') do
    it { should belong_to(:user) }
    it { should belong_to(:comment) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe('validations') do
    it { should validate_presence_of(:content) }
  end
end
