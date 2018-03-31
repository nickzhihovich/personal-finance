FactoryBot.define do
  factory :category do
    amount { Faker::Number.decimal(3, 2) }
    title { Faker::Internet.user_name(5..15) }

    trait :main_category do
      categorizable { |category| category.association(:user) }
    end

    trait :sub_category do
      categorizable { |category| category.association(:category) }
    end
  end
end
