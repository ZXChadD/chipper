FactoryGirl.define do
  factory :tweet do
    association :user, factory: :user
    body 'body'
    trait :invalid do
      body nil
    end
  end
end
