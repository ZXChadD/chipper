# frozen_string_literal: true

FactoryGirl.define do
  factory :retweet do
    content 'MyString'
    user nil
    tweet nil
  end
end
