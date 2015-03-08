class RecipeIngredient < ActiveRecord::Base
	belongs_to :recipe
	belongs_to :ingredient,:foreign_key=>'ingredients_id'
end
