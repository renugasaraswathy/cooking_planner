module RecipesHelper
	def active_class(tab_no,action_name)
		if tab_no=="basic" and action_name=="edit"
			"active"
		elsif tab_no=="ingredients" and action_name=="ingredients"
			"active"
		elsif tab_no=="prerequisities" and action_name=="prerequisities"
			"active"
		elsif tab_no=="steps" and action_name=="steps"
			"active"
		end
	end	

	def food_type(recipe,class_name)
		if recipe.diet_type==VEGETARIAN
			image_tag "veg.png",:class=>class_name	
		else
			image_tag "non-veg.png",:class=>class_name	
		end
	end

	def recipe_type_text(recipe)
		recipe_type=recipe.recipe_type
		if recipe_type==PRIVATE
			"<i class='fa fa-group'></i> shared with family members".html_safe
		else
			"<i class='fa fa-globe'></i> shared with everyone".html_safe
		end
	end

end
