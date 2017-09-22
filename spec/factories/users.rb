FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@test.com" }

  factory :user do
    confirmed_at Time.now - 1.days
    email
    password '123456789'
    password_confirmation '123456789'
  end
end
