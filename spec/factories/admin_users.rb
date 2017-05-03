# frozen_string_literal: true

FactoryGirl.define do
  factory :admin_user do
    email { FFaker::Internet.email }
    password { FFaker::Lorem.word }
  end
end
