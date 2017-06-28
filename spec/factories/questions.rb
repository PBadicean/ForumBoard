FactoryGirl.define do
  factory :question do
    sequence(:title){ |n| "MyString#{n}" }
    sequence(:body){ |n| "MyText#{n}" }
  end

  factory :invalid_question, class: "Question"do
    title nil
    body nil
  end
end
