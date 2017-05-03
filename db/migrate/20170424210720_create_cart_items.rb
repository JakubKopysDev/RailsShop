# frozen_string_literal: true
class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
      t.belongs_to :cart, index: true, foreign_key: true, null: false
      t.belongs_to :product, index: true, foreign_key: true, null: false, on_delete: :cascade

      t.timestamps
    end
  end
end
