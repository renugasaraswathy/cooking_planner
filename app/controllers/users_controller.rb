class UsersController < ApplicationController
	before_action :set_user
	def show
		if current_user.family==@user.family
			@recipes=@user.recipes
		else
			@recipes=@user.recipes.public_recipes
		end
	end

private
	def set_user
      @user = User.find_by_slug(params[:id])
    end
end
