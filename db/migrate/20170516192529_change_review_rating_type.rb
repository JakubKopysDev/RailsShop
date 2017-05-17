class ChangeReviewRatingType < ActiveRecord::Migration[5.0]
  def change
    change_table :reviews do |t|
      t.change :rating, :integer, unsigned: true, null: false
    end
  end
end
