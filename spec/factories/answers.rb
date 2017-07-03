FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "MyString#{n}" }
    question
    user
  end

  factory :invalid_answer, class: "Answer"do
    body nil
    user nil
    question nil
  end
end
