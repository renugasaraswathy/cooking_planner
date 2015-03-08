class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :description
      t.integer :no_of_persons
      t.text :description
      t.boolean :has_prerequisites,:default=>false
      t.integer :recipe_type,:default=>1
      t.integer :diet_type
      t.string :time_required
      t.integer :user_id
      t.integer :published,:default=>3
      t.string :slug
      t.references :category
      t.timestamps
    end
  end
end
