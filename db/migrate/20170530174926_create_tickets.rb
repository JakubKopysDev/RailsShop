class CreateTickets < ActiveRecord::Migration[5.0]
  def change
    create_table :tickets do |t|
        t.text :content, null: false
        t.string :email, null: false
        t.string :name,  null: false
        t.belongs_to :user, index: true, foreign_key: true, on_delete: :nullify

        t.timestamps
    end
  end
end
