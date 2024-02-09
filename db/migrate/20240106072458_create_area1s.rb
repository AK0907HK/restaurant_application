class CreateArea1s < ActiveRecord::Migration[7.0]
  def change
    create_table :area1s do |t|
      t.string :name

      t.timestamps
    end
  end
end
