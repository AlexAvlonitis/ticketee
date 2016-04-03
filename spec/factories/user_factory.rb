FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test#{n}@email.org" }
    password "asdasdasd"
  end
end
