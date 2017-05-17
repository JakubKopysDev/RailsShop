# frozen_string_literal: true

def seed_image(file_name)
  File.open(Rails.root.join('public', 'images', 'seed', file_name))
end

users = []

users << User.create(name: 'Jakub', email: 'foo@bar.com', password: 'foobar')

10.times do
  users << FactoryGirl.create(:user)
end

10.times do
  product = Product.create(
    name: Faker::Lorem.unique.words(rand(3) + 1).join(' '),
    description: Faker::Lorem.paragraph(3, false, 2),
    price: Faker::Number.between(10, 1000) / 10.0
  )
  3.times do
    FactoryGirl.create :review, product: product, user: users.sample
  end
end

3.times do |n|
  product = Product.create(
    name: Faker::Lorem.unique.words(rand(3) + 1).join(' '),
    description: Faker::Lorem.paragraph(3, false, 2),
    price: Faker::Number.between(10, 1000) / 10.0,
    image: seed_image("prod#{n + 1}.png")
  )
  3.times do
    FactoryGirl.create :review, product: product, user: users.sample
  end
end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password')
