class CreateRates < ActiveRecord::Migration[5.2]
  def change
    create_table :rates do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :point
      t.timestamps
    end
    # add_index :rates, :user_id
    # add_index :rates, :book_id
    add_index :rates, [:user_id, :book_id], unique: true
  end
end
