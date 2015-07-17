class AddWunderlistUserId < ActiveRecord::Migration
  def up
	  add_column :users, :wunderlist_user_id, :integer
  end
  
  def down
	  remove_column :users, :wunderlist_user_id
  end
end
