FactoryBot.define do
  factory :like do
    transient do
      likable { create(:comment) }
    end

    user
    likable_type { likable.class.name }
    likable_id { likable.id }

    initialize_with { new(attributes) }
  end
end
