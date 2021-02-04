class UpdateFriendColumnNames < ActiveRecord::Migration[5.2]
  def change
    rename_column :friends, :user_id, :friend1_id
    rename_column :friends, :friend_id, :friend2_id
  end
end
