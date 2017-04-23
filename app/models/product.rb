class Product < ApplicationRecord
  has_attached_file :image, styles: { medium: "350x150", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def delete_image
    self.image.destroy
    self.image = nil
    self.save
  end
end
