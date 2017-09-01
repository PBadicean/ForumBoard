FactoryGirl.define do
  factory :comment do
    sequence(:body){ |n| "Mycomment#{n}" }
    association :commentable
     factory :invalid_comment do
       body nil
       association :commentable
    end
  end
end
