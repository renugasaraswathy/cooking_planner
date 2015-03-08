class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy,:sub_categories]

  respond_to :html

  def index
    @categories = Category.all.paginate(:page => params[:page], :per_page => 10)
    @popular_categories=Category.popular_categories(current_user)
    respond_with(@categories)
  end

  def show
    @family_private_recipes=@category.recipes.where(:user_id=>current_user.family.users.collect(&:id),:recipe_type=>PRIVATE)
    @all_public_recipes=@category.recipes.public_recipes
    @recipes=@family_private_recipes + @all_public_recipes
    @recipes=@recipes.sort { |a,b| b.created_at<=>a.created_at }    
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
    unless @category.user==current_user
      flash[:error]="You dont have access to edit this category"
      redirect_to categories_path and return
    end
  end

  def create
    @category = Category.new(category_params)
    @category.user=current_user
    @category.save
    respond_with(@category)
  end

  def update
    @category.update(category_params)
    respond_with(@category)
  end

  def destroy
    @category.destroy
    respond_with(@category)
  end
  
  private
    def set_category
      @category = Category.find_by_slug(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
