# frozen_string_literal: true

class Category < ApplicationRecord
  # has_and_belongs_to_many :products, join_table: :categories_products
  has_many :categorizations
  has_many :categories, through: :categorizations
end
