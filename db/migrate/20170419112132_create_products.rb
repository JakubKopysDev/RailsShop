class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name,       null: false
      t.text :description,  null: false
      t.float :price,       null: false

      t.timestamps null: false
    end

    add_index :products, :name, unique: true
    add_attachment :products, :image
  end
end
