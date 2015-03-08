module ApplicationHelper
	def flash_message
		if flash[:notice]
			"<div class='alert alert-success alert-dismissable'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{flash[:notice]}</div>".html_safe
		elsif flash[:error]
			"<div class='alert alert-danger alert-dismissable'><button type='button' class='close' data-dismiss='alert'>&times;</button>#{flash[:error]}</div>".html_safe
		end
	end

	def active_class(controller,link)		
			if controller==link
				"active"
			end		
	end

	def recipe_image_tag(recipe,size,class_name)
		if !recipe.avatar
			image_tag("default-#{size}-pic.jpg",:class=>class_name)
		else			
			image_tag(recipe.avatar.picture.url(size.to_sym),:class=>class_name)
		end
	end

	def time_taken(recipe)
		time=""
		if recipe.show_hours.to_i > 0 
			time << recipe.show_hours << " hours"
		end	
		time << " "
        time << recipe.show_minutes << " minutes"
        return time
	end

	def diet_type_icon(recipe)
		if recipe.diet_type==VEGETARIAN
			color="success"
			text="Veg"
		else
			color="danger"
			text="Non Veg"
		end
		return "<i class='fa fa-circle #{color}'></i> #{text}".html_safe
	end
end
