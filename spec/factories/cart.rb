# frozen_string_literal: true

FactoryGirl.define do
  factory :cart do
    association :user
  end
end
