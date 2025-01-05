class CreateTimings < ActiveRecord::Migration[7.0]
  def change
    create_table :timings do |t|
      t.string :timing

      t.timestamps
    end
  end
end
