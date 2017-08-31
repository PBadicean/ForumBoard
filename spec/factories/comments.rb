FactoryGirl.define do
  factory :comment do
    sequence(:body){ |n| "Mycomment#{n}" }
  end
end
