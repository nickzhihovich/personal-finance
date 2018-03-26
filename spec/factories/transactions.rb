FactoryBot.define do
  factory :transaction do
    user
    amount { Faker::Number.decimal(3, 2) }
    date { Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.current) }
  end
end
