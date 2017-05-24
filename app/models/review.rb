# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :product
  after_create :recalculate_cache
  after_destroy :recalculate_cache

  validates :comment, length: { in: 4..255 }
  validates :rating, numericality: { only_integer: true,
                                     greater_than_or_equal_to: 1,
                                     less_than_or_equal_to: 5 }

  private

  def recalculate_cache
    product.calculate_average_rating
  end
end
