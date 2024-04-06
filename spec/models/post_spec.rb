require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:user) { FactoryBot.create(:user) }

  describe('validations') do
    it('is valid with valid attributes') do
      post = Post.new(user:, title: 'Test Post', content: 'Lorem ipsum' * 20)
      expect(post).to be_valid
    end

    it('is not valid without a title') do
      post = Post.new(user:, content: 'Lorem ipsum' * 20)
      expect(post).to_not be_valid
    end

    it('is not valid without content') do
      post = Post.new(user:, title: 'Test Post')
      expect(post).to_not be_valid
    end

    it('is not valid without a user') do
      post = Post.new(title: 'Test Post', content: 'Lorem ipsum' * 20)
      expect(post).to_not be_valid
    end

    it('is not valid with a title less than 5 characters') do
      post = Post.new(user:, title: 'Test', content: 'Lorem ipsum' * 20)
      expect(post).to_not be_valid
    end

    it('is not valid with a title more than 200 characters') do
      post = Post.new(user:, title: 'a' * 201, content: 'Lorem ipsum' * 20)
      expect(post).to_not be_valid
    end

    it('is not valid with a duplicate title') do
      Post.create(user:, title: 'Test Post', content: 'Lorem ipsum' * 20)
      post = Post.new(user:, title: 'Test Post', content: 'Lorem ipsum' * 20)
      expect(post).to_not be_valid
    end

    it('is not valid with a content less than 100 characters') do
      post = Post.new(user:, title: 'Test Post', content: 'a' * 30)
      expect(post).to_not be_valid
    end
  end
end
