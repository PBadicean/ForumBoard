FactoryGirl.define do
  factory :authorization do
    sequence(:provider) { |n| "my_#{n}_provider" }
    sequence(:uid) { |n| "#{n}_user_uid" }
    user
  end
end
