FactoryBot.define do
  factory :transaction do
    user
    amount { Faker::Number.decimal(3, 2) }
    date { Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.current) }

    trait :balance_transactions do
      transactinable { |transaction| transaction.association(:balance_transaction) }
    end

    trait :category_transactions do
      transactinable { |transaction| transaction.association(:category_transaction) }
    end

    trait :between_categories_transactions do
      transactinable { |transaction| transaction.association(:between_categories_transaction) }
    end
  end
end
