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
  product = FactoryGirl.create :product
  3.times do
    FactoryGirl.create :review, product: product, user: users.sample
  end
end

3.times do
  product = FactoryGirl.create :product_with_pictures
  3.times do
    FactoryGirl.create :review, product: product, user: users.sample
  end
end

3.times do
  Product.create!(
    name: Faker::Commerce.unique.product_name[0..24],
    description: Faker::Lorem.sentences(rand(1..3)).join(' '),
    price: Faker::Number.between(10, 1000) / 10.0,
    pictures_attributes: [
      { file: seed_image('prod1.png') },
      { file: seed_image('prod2.png') },
      { file: seed_image('prod3.png') },
      { file: seed_image('prod4.png') },
      { file: seed_image('prod5.png') }
    ]
  )
end

AdminUser.create!(email: 'admin@example.com',
                  password: 'password',
                  password_confirmation: 'password')
