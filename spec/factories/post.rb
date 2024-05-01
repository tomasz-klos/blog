FactoryBot.define do
  factory :post do
    user
    title { 'Test Post' }
    content { 'Lorem ipsum' * 25 }
    state { 'draft' }

    trait :published do
      state { 'published' }
    end
  end
end
