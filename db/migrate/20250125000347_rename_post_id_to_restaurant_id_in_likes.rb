class RenamePostIdToRestaurantIdInLikes < ActiveRecord::Migration[7.0]
  def change
    rename_column :likes, :post_id, :restaurant_id
  end
end
