FactoryBot.define do
  factory :expense_transaction do
    association(:category)
  end
end
