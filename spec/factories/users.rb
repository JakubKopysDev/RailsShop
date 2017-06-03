# frozen_string_literal: true

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Internet.user_name(6..20) }
    password { Faker::Lorem.characters(6) }
    city { Faker::Address.city }
    country { Faker::Address.country_code }
    phone_number { '+' + Faker::Number.number(11) }
  end
end
