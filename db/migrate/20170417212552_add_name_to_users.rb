# frozen_string_literal: true
class AddNameToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :name, :string, null: false, default: ""
    add_index :users, :name, unique: true
  end
end
