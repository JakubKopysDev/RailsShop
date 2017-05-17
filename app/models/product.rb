# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :reviews, dependent: :destroy

  has_attached_file :image, styles: { medium: '350x150' },
                            default_url: '/images/:style/missing.png'
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\z}
  validates :name, length: { in: 4..25 }, uniqueness: true
  validates :description, length: { in: 4..500 }
  validates :price, numericality: { greater_than_or_equal_to: 1.0 }
  validate :validate_categories

  def delete_image
    image.destroy
    self.image = nil
    save
  end

  def calculate_average_rating
    ratings = reviews.pluck(:rating)
    avg = ratings.inject { |sum, el| sum + el }.to_f / ratings.size
    self.rating_cache = avg.round(1)
    self.review_count = reviews.count
    save!
  end

  private

  def validate_categories
    message = 'too many (You can only select 3)'
    errors.add(:categories, message) if categories.size > 3
  end
end
