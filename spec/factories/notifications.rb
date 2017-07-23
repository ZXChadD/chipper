# frozen_string_literal: true

FactoryGirl.define do
  factory :notification do
    recipient_id 1
    actor_id 1
    read_at '2017-06-12 16:44:45'
    action 'MyString'
    notifiable_id 1
    notifiable_type 'MyString'
  end
end
