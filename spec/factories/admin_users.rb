# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    username { FFaker::Internet.user_name }
    password { FFaker::Lorem.word }
    confirmed_at Time.current
  end
end
