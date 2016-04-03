FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.org" }
    password "asdasdasd"

    trait :admin do
      admin true
    end
  end
end
