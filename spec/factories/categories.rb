# frozen_string_literal: true

FactoryGirl.define do
  factory :category do
    name { Faker::Lorem.characters(rand(6..20)) }
  end
end
