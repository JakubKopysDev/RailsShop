# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  after_create :recalculate_cache
  after_destroy :recalculate_cache

  def recalculate_cache
    product.calculate_average_rating
  end
end
