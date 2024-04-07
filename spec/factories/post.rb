FactoryBot.define do
  factory :post do
    user
    title { 'Test Post' }
    content { 'Lorem ipsum' * 25 }
  end
end
