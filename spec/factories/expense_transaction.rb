FactoryBot.define do
  factory :expense_transaction do
    association(:category)
    comment { Faker::Internet.slug }
  end
end
