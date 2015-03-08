class RecipeStep < ActiveRecord::Base
	scope :ordered_by_step_no,->{order('step_no asc')}
end
