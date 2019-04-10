class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.integer :user_id
      t.integer :target_id
      t.string :target_type
      t.references :target, polymorphic: true, index: true

      t.timestamps
    end
    add_index :follows, [:user_id, :target_id, :target_type], unique: true
  end
end
