class AddWunderlistIdToLists < ActiveRecord::Migration
  def up
	add_column :lists, :wunderlist_id, :integer
  end
  
  def down
	  remove_column :lists, :wunderlist_id
	end
end


