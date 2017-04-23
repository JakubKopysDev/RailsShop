environment_seed_file = File.join(Rails.root, 'db', 'seeds', "#{Rails.env}.rb")

def seed_image(file_name)
  File.open(File.join(Rails.root, "/public/images/seed/#{file_name}"))
end

User.create({
  name: 'Jakub',
  email: 'foo@bar.com',
  password: 'foobar'
})

7.times do |n|
  Product.create({
    name: Faker::Lorem.unique.words(rand(3) +1).join(' '),
    description: Faker::Lorem.paragraph(3, false, 2),
    price: Faker::Number.between(10, 1000) / 10.0,
    image: seed_image("prod#{n+1}.png")
  })
end

20.times do |n|
  Product.create({
    name: Faker::Lorem.unique.words(rand(3) +1).join(' '),
    description: Faker::Lorem.paragraph(3, false, 2),
    price: Faker::Number.between(10, 1000) / 10.0,
  })
end
