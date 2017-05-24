# frozen_string_literal: true

def seed_image(file_name)
  File.open(Rails.root.join('public', 'images', 'seed', file_name))
end

FactoryGirl.define do
  factory :picture do
    association :product
  end

  factory :product do
    name { Faker::Commerce.unique.product_name[0..24] }
    description { Faker::Lorem.sentences(rand(1..3)).join(' ') }
    price { Faker::Number.between(10, 1000) / 10.0 }

    factory :product_with_presistent_pictures do
      transient do
        pictures_count 4
        file_name 'default.png'
      end

      after(:create) do |product, evaluator|
        create_list(
          :picture,
          evaluator.pictures_count,
          product: product,
          # file: seed_image(evaluator.file_name)
          file: Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, "/public/images/seeed/#{filename}")))
        )
      end
    end
  end
end
