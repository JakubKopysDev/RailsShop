# frozen_string_literal: true

def seed_image(file_name)
  File.open(Rails.root.join("/public/images/seed/#{file_name}"))
end

User.create(name: 'Jakub',
            email: 'foo@bar.com',
            password: 'foobar')

10.times do |_n|
  Product.create(name: Faker::Lorem.unique.words(rand(3) + 1).join(' '),
                 description: Faker::Lorem.paragraph(3, false, 2),
                 price: Faker::Number.between(10, 1000) / 10.0)
end

3.times do |n|
  Product.create(name: Faker::Lorem.unique.words(rand(3) + 1).join(' '),
                 description: Faker::Lorem.paragraph(3, false, 2),
                 price: Faker::Number.between(10, 1000) / 10.0,
                 image: seed_image("prod#{n + 1}.png"))
end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password')
