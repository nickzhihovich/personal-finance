FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password Faker::Internet.password
    confirmed_at Faker::Time.backward(20)
  end
end
