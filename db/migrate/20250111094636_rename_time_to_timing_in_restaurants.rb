class RenameTimeToTimingInRestaurants < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurants, :time, :timing
  end
end
