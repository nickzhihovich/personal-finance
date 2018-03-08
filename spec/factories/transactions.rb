FactoryBot.define do
  factory :transaction do
    user
    sum 100
    date Date.current
  end
end
