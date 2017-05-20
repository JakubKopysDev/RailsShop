class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.belongs_to :product, index: true, foreign_key: true, null: false, on_delete: :cascade
      t.string :file

      t.timestamps
    end
  end
end
