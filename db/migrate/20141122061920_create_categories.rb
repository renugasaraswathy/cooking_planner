class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.references :user
      t.string :name
      t.string :slug,:unique=>true
      t.timestamps
    end
  end
end
