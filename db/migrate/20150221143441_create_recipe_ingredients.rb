class CreateRecipeIngredients < ActiveRecord::Migration
  def change
    create_table :recipe_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredients_id
      t.float :amount
      t.integer :unit
      t.timestamps
    end
  end
end
