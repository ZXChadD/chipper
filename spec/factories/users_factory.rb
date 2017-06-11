FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "#{n}" }
    sequence(:email) { |n| "email#{n}@example.com" }
    password '123456789'
  end
end
