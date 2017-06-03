# frozen_string_literal: true

FactoryGirl.define do
  factory :ticket do
    association :user
    email { Faker::Internet.email }
    name { Faker::Internet.user_name(6..20) }
    content { Faker::Lorem.sentences(rand(2..5)).join(' ') }
  end
end
