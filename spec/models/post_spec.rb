require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }

  describe('validations') do
    context('with valid attributes') do
      let(:post) { FactoryBot.build(:post, user:, title: 'Test Post', content: 'Lorem ipsum' * 25) }

      it { expect(post).to be_valid }
    end

    context('with invalid attributes') do
      it('is not valid without a title') do
        post = FactoryBot.build(:post, user:, title: nil)
        expect(post).to_not be_valid
      end

      it('is not valid without content') do
        post = FactoryBot.build(:post, user:, content: nil)
        expect(post).to_not be_valid
      end

      it('is not valid without a user') do
        post = FactoryBot.build(:post, user: nil)
        expect(post).to_not be_valid
      end

      it('is not valid with a title less than 5 characters') do
        post = FactoryBot.build(:post, user:, title: 'Test', content: 'Lorem ipsum' * 25)
        expect(post).to_not be_valid
      end

      it('is not valid with a title more than 200 characters') do
        post = FactoryBot.build(:post, user:, title: 'a' * 201, content: 'Lorem ipsum' * 25)
        expect(post).to_not be_valid
      end

      it('is not valid with a content less than 100 characters') do
        post = FactoryBot.build(:post, user:, title: 'Test Post', content: 'a' * 50)
        expect(post).to_not be_valid
      end
    end
  end

  describe('associations') do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
