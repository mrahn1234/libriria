class CreateBookcategories < ActiveRecord::Migration[5.2]
  def change
    create_table :bookcategories do |t|

    	t.references :book, foreign_key: true
    	t.references :category, foreign_key: true
      t.timestamps
    end
  end
end
