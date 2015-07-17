class CreateTasks < ActiveRecord::Migration
  def up
	  create_table :tasks do |t|
		  t.string :name
		  t.boolean :done?
		  t.string :list_id
	end
  end
  
  def down
	  drop_table :tasks
	end
end
