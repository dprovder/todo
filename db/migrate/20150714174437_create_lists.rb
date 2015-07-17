class CreateLists < ActiveRecord::Migration
  def up
	  create_table :lists do |t|
		  t.string :name
		  t.integer :user_id
		  t.boolean :done?
	end
  end
  
  def down
	  drop_table :lists
  end
end
