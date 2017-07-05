FactoryGirl.define do
  factory :answer do
    sequence(:body) { |n| "MyString#{n}" }
    question
    user

    factory :invalid_answer do
      body nil
      user nil
      question nil
    end
  end
end
