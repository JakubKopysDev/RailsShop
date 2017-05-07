# frozen_string_literal: true

FactoryGirl.define do
  factory :admin_user do
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(rand(6..20)) }
  end
end
