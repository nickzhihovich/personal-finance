FactoryBot.define do
  factory :category_transaction do
    association(:category, :main_category)
  end
end
