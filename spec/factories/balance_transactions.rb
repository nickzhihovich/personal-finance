FactoryBot.define do
  factory :balance_transaction do
    comment { Faker::Internet.slug }
  end
end
