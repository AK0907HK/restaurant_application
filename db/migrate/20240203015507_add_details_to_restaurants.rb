class AddDetailsToRestaurants < ActiveRecord::Migration[7.0]
  def change
    add_column :restaurants, :lat, :float
    add_column :restaurants, :lng, :float
  end
end
