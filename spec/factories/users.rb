# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name(6..20) }
    password { Faker::Lorem.characters(6) }
  end
end
