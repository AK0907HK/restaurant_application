class CreateRestaurants < ActiveRecord::Migration[7.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.integer :user_r_id
      t.integer :post_r_id
      t.string :area1
      t.string :area2
      t.string :type
      t.string :time
      t.text :coment
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
      add_index :restaurants, [:user_r_id, :created_at]
  end
end  