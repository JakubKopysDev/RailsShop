class Product < ApplicationRecord
  has_attached_file :image, styles: { medium: "350x150" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
  validates :name, length: {in: 4..25}, uniqueness: true
  validates :description, length: {in: 4..500}
  validates :price, numericality: {greater_than_or_equal_to: 1.0}

  has_many :cart_items, dependent: :destroy

  def delete_image
    self.image.destroy
    self.image = nil
    self.save
  end
end
