require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe('validations') do
    let(:valid_attributes) { { user:, title: 'Test Post', content: 'Lorem ipsum' * 25 } }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:content) }

    context('with valid attributes') do
      it('is valid') do
        post = FactoryBot.build(:post, valid_attributes)
        expect(post).to be_valid
      end
    end

    context('with invalid attributes') do
      it('is not valid without a title') do
        post = FactoryBot.build(:post, valid_attributes.merge(title: nil))
        expect(post).to_not be_valid
      end

      it('is not valid without content') do
        post = FactoryBot.build(:post, valid_attributes.merge(content: nil))
        expect(post).to_not be_valid
      end

      it('is not valid without a user') do
        post = FactoryBot.build(:post, valid_attributes.merge(user: nil))
        expect(post).to_not be_valid
      end

      it('is not valid with a title less than 5 characters') do
        post = FactoryBot.build(:post, valid_attributes.merge(title: 'Test'))
        expect(post).to_not be_valid
      end

      it('is not valid with a title more than 200 characters') do
        post = FactoryBot.build(:post, valid_attributes.merge(title: 'a' * 201))
        expect(post).to_not be_valid
      end

      it('is not valid with a content less than 100 characters') do
        post = FactoryBot.build(:post, valid_attributes.merge(content: 'a' * 50))
        expect(post).to_not be_valid
      end
    end
  end

  describe('associations') do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end
