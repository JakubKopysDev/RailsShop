class CreateCategorizations < ActiveRecord::Migration[5.0]
  def change
    create_table :categorizations do |t|
      t.column :category_id, :integer
      t.column :product_id, :integer
    end
  end
end
