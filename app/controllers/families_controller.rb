class FamiliesController < ApplicationController
	before_action :already_joined,only: [:new,:create]
	respond_to :html
	skip_before_filter :joined_family
	before_action :set_family, only: [:show,:edit,:update]
	def new
		@family=Family.new
	end

	def create
	    @family = Family.new(family_params)
	    if @family.save
	    	@family.add_family_members(current_user)
		end
	    respond_with(@family)
	end

	def show
		if current_user.family==@family
			@family_recipes=Recipe.where(:user_id=>@family.users.collect(&:id))			
		else
			flash[:error]="You dont have access to view this family"
			redirect_to root_path
		end
	end

	def edit
		unless current_user.family==@family
			flash[:error]="You dont have access to edit this family"
			redirect_to root_path
		end
	end

	def update
		if @family.update(family_params)      
			flash[:notice]="Your family details has been successfully updated"
      		redirect_to @family
	    else
	      render :edit
	    end
	end

	def join

	end

	def joining
		access_code=params[:access_code]
		@family=Family.find_by_access_code(access_code)
		if @family
			@family.family_members.create(:user=>current_user)
			flash[:notice]="You have been added to this family"
			redirect_to @family
		else
			flash[:error]="Invalid access code"
			render :action=>'join'
		end
	end

	def already_joined
		if !current_user.family
		else
			redirect_to root_path
		end
	end
 private
 def family_params
      params.require(:family).permit(:name,:access_code)
 end

 def set_family
 	@family = Family.find_by_slug(params[:id])
 end
end
