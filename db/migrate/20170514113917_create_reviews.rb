# frozen_string_literal: true
class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user, index: true, foreign_key: true, null: false, on_delete: :cascade
      t.belongs_to :product, index: true, foreign_key: true, null: false, on_delete: :cascade
      t.text :comment, null: false
      t.float :rating, unsigned: true, null: false

      t.timestamps
    end
  end
end
