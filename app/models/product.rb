# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :categorizations
  has_many :categories, through: :categorizations
  has_many :reviews, dependent: :destroy
  has_many :pictures, dependent: :destroy, inverse_of: :product
  accepts_nested_attributes_for :pictures, allow_destroy: true

  validates :name, length: { in: 4..25 }, uniqueness: true
  validates :description, length: { in: 4..500 }
  validates :price, numericality: { greater_than_or_equal_to: 1.0 }
  validates :pictures, length: { maximum: 5 }
  validate :validate_categories

  after_save :set_default_picture, if: (proc do |product|
    product.pictures.blank?
  end)

  def calculate_average_rating
    ratings = reviews.pluck(:rating)
    avg = ratings.inject { |sum, el| sum + el }.to_f / ratings.size
    self.rating_cache = avg.round(1)
    self.review_count = reviews.count
    save!
  end

  def images
    pictures.map(&:file)
  end

  def image
    images.first
  end

  def self.autocomplete_json(query)
    where("lower(name) like ?", "%#{query}%")
    .select(:name, :id).collect do |product|
      {
        value: product.name,
        data: product.id
      }
    end.to_json
  end

  private

  def validate_categories
    message = 'too many (You can only select 3)'
    errors.add(:categories, message) if categories.size > 3
  end

  def set_default_picture
    picture = pictures.build
    picture.save
  end

  def invalid_file?(attributes)
    attributes['filename'].blank? and attributes['filename_cache'].blank?
  end
end
