FactoryGirl.define do
  factory :user do
    password '123456789'
    password_confirmation '123456789'
    sequence(:email) { |n| "user#{n}@test.com" }
  end
end
