class RemoveAttachmentFromProducts < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :products, :image
  end
end
