FactoryBot.define do
  factory :reply do
    user
    comment
    content { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
  end
end
