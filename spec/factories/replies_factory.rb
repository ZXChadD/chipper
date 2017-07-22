# frozen_string_literal: true

FactoryGirl.define do
  factory :reply do
    association :user, factory: :user
    association :tweet, factory: :tweet
    body 'body'
    trait :invalid do
      body nil
    end
  end
end
