class AddRatingCacheAndCountToProducts < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :rating_cache, :float, unsigned: true, default: 3.0, null: false
    add_column :products, :review_count, :integer, unsigned: true, default: 0, null: false
  end
end
