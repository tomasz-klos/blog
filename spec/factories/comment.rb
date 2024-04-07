FactoryBot.define do
  factory :comment do
    user
    post
    content { 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.' }
  end
end
