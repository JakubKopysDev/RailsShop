# frozen_string_literal: true

FactoryGirl.define do
  factory :review do
    association :user
    association :product
    comment { Faker::Lorem.sentences(rand(1..3)).join(' ') }
    rating { Faker::Number.between(1, 5) }
  end
end
