FactoryBot.define do
  factory :transaction do
    user
    amount 100
    date Date.current
  end
end
