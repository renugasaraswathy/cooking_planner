class CreateAvatars < ActiveRecord::Migration
  def change
    create_table :avatars do |t|
      t.string :node_type
      t.integer :node_id	
      t.timestamps
    end
  end
end
