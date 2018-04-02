FactoryBot.define do
  factory :category do
    user
    amount { Faker::Number.decimal(3, 2) }
    title { Faker::Internet.user_name(5..15) }

    factory :main_category do
      categorizable { |category| category.association(:user) }
    end

    factory :sub_category do
      categorizable { |category| category.association(:category) }
    end
  end
end
