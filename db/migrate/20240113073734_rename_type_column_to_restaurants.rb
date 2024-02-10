class RenameTypeColumnToRestaurants < ActiveRecord::Migration[7.0]
  def change
    rename_column :restaurants, :type, :genre
  end
end
