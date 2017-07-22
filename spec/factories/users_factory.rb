# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    sequence(:username, &:to_s)
    sequence(:email) { |n| "email#{n}@example.com" }
    password '123456789'
  end
end
