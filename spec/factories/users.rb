# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { FFaker::Internet.email }
    name { FFaker::Internet.user_name }
    password { FFaker::Lorem.characters(6) }
  end
end
