# frozen_string_literal: true

namespace :categories do
  desc 'Seeds categories'
  task seed_categories: :environment do
    categories = ['electronics', 'fashion and beauty', 'home', 'health',
                  'culture and entertainment', 'sport and recreation',
                  'motorization', 'collections and art', 'technology',
                  'science']

    categories.each do |category|
      Category.create!(name: category)
    end

    p "Created #{Category.count} categories."
  end
end
