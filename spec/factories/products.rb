# frozen_string_literal: true

FactoryGirl.define do
  factory :product do
    name { Faker::Commerce.product_name[0..24] }
    description { Faker::Lorem.sentences(rand(1..3)).join(' ') }
    price { Faker::Number.between(10, 1000) / 10.0 }
  end
end
