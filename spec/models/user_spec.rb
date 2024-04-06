require 'rails_helper'

RSpec.describe User, type: :model do
  it('should be valid') do
    user = User.new(email: 'email@example.com', password: 'password')
    expect(user).to be_valid
  end

  it('should be invalid without an email') do
    user = User.new(email: nil, password: 'password')
    expect(user).not_to be_valid
  end

  it('should be invalid without a password') do
    user = User.new(email: 'email@example.com', password: nil)
    expect(user).not_to be_valid
  end

  it('should be invalid with a duplicate email') do
    User.create(email: 'email@example.com', password: 'password')
    user = User.new(email: 'email@example.com', password: 'password')
    expect(user).not_to be_valid
  end

  it('should be invalid with a password less than 6 characters') do
    user = User.new(email: 'email@example.com', password: 'pass')
    expect(user).not_to be_valid
  end
end
