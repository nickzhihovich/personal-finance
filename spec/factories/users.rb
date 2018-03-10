FactoryBot.define do
  sequence :email do |n|
    "test#{n}@example.com"
  end

  factory :user do
    email { generate :email }
    password 'asdfasdf'
    password_confirmation 'asdfasdf'
    confirmed_at Time.current
  end
end
