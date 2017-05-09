# frozen_string_literal: true

FactoryGirl.define do
  factory :cart_item do
    association :product
    association :cart
  end
end
