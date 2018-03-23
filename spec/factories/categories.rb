FactoryBot.define do
  factory :category do
    user
    amount { Faker::Number.decimal(3, 2) }
    title { Faker::Internet.user_name(5..15) }
  end
end
