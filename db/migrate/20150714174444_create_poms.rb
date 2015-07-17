class CreatePoms < ActiveRecord::Migration
  def up
	  create_table :poms do |t|
		  t.integer :list_id
		  t.boolean :work?
		end
  end
  
  def down 
	  drop_table :poms 
	end
end
