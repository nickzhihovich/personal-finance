FactoryBot.define do
  factory :category do
    user
    amount { Faker::Number.digit }
    title { Faker::Internet.user_name(5..15) }
  end
end
