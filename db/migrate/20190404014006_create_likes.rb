class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true

      t.timestamps
    end
    # add_index :likes, :user_id 
    # add_index :likes, :book_id
    add_index :likes, [:user_id, :book_id], unique: true #tao 1 cap khoa duy nhat
  end
end
