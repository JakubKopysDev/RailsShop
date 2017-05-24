class AddInfoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :country, :string
    add_column :users, :city, :string
    add_column :users, :street, :string
    add_column :users, :post_code, :string
    add_column :users, :phone_number, :string
    add_column :users, :avatar, :string
    add_column :users, :credit_card_number, :string
    add_column :users, :credit_card_sec, :string
    add_column :users, :exp_date, :date
  end
end
