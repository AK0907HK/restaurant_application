class CreateArea2s < ActiveRecord::Migration[7.0]
  def change
    create_table :area2s do |t|
      t.string :prefeture
      t.string :city
      t.references :area1, null: false, foreign_key: true

      t.timestamps
    end
  end
end
