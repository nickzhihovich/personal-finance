FactoryBot.define do
  factory :transaction do
    user
    amount { Faker::Number.decimal(3, 2) }
    date { Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.current) }

    trait :balance_trans do
      transactinable { |transaction| transaction.association(:balance_transaction) }
    end

    trait :category_trans do
      transactinable { |transaction| transaction.association(:category_transaction) }
    end
  end
end
