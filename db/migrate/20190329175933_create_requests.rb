class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.datetime :day_from
      t.datetime :day_to
      t.int :verify
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
