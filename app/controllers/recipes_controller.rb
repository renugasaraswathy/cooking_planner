class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy,:prerequisities,:save_prerequisities,:ingredients,:save_ingredients,:steps,:save_steps]

  respond_to :html

  def index
    @recipes = Recipe.all
    respond_with(@recipes)
  end

  def show
    if @recipe.recipe_type==PRIVATE and @recipe.user.family!=current_user.family
      flash[:error]="It is a private recipe. You dont have access"
      redirect_to root_path and return
    else
      @recipe_ingredients=@recipe.recipe_ingredients
      @recipe_steps=@recipe.recipe_steps.ordered_by_step_no
      @recipe_prerequisites=@recipe.prerequisites_steps.ordered_by_step_no
      @recipe_dates=@recipe.food_plans.where(:family=>current_user.family)
      respond_with(@recipe)
    end
  end

  def new
    @categories=Category.all
    if !@categories.empty?
      @recipe = Recipe.new
      if params[:category] and Category.find_by_slug(params[:category])
        @recipe.category=Category.find_by_slug(params[:category])
      end
      
      respond_with(@recipe)
    else
      flash[:error]="Add categories first"
      redirect_to new_category_path
    end
  end

  def prerequisities
    @prerequisities=@recipe.prerequisites_steps.ordered_by_step_no
  end

  def steps
    @recipe_steps=@recipe.recipe_steps.ordered_by_step_no
  end

  def save_steps    
       steps=steps_params["desc"].reject(&:empty?)
       step_nos=steps_params["step_no"].reject(&:empty?) 
        steps.each do |step|
          step_no=step_nos[steps.index(step)]
          recipe_step=@recipe.recipe_steps.where(:step_no=>step_no).first
          if recipe_step
            recipe_step.update_attributes(:description=>step)
          else
            @recipe.recipe_steps.create(:description=>step,:step_no=>step_no)
          end
        end      
      redirect_to @recipe 
  end

  def ingredients
    @ingredients=@recipe.recipe_ingredients
  end

  def save_ingredients
    names=params[:name].reject(&:empty?)
    amount=params[:amount].reject(&:empty?)
    unit=params[:unit]
    already_added_recipe_ingredients=@recipe.recipe_ingredients.collect{ |r_i| r_i.ingredient.name }
    recipes_to_be_deleted=already_added_recipe_ingredients-names
    names.each do |name|      
      ingredient=Ingredient.find_by_name(name)
      unless ingredient
        ingredient=Ingredient.create(:name=>name)
      end
      if ingredient
        unless RecipeIngredient.find_by_ingredients_id_and_recipe_id(ingredient.id,@recipe.id)
          @recipe.recipe_ingredients.create(:ingredients_id=>ingredient.id,:amount=>amount[names.index(name)].to_f,:unit=>unit[names.index(name)])        
        end
      end      
    end

    recipes_to_be_deleted.each do |r|
      ingredient=Ingredient.find_by_name(r)
      RecipeIngredient.find_by_ingredients_id_and_recipe_id(ingredient.id,@recipe.id).delete
    end

    if @recipe.has_prerequisites
    redirect_to prerequisities_recipes_path(@recipe.slug)
  else
    redirect_to steps_recipes_path(@recipe.slug)
  end
  end

  def ingredients_list
    @ingredients=Ingredient.select(:id,:name).where("name like ?","#{params[:q]}\%")
    render json: @ingredients
  end

  def save_prerequisities
    if @recipe.has_prerequisites==true
     steps=prerequisities_params["desc"].reject(&:empty?)
     step_nos=prerequisities_params["step_no"].reject(&:empty?) 
      steps.each do |step|
        step_no=step_nos[steps.index(step)]
        prerequisite=@recipe.prerequisites_steps.where(:step_no=>step_no).first
        if prerequisite
          prerequisite.update_attributes(:description=>step)
        else
          @recipe.prerequisites_steps.create(:description=>step,:step_no=>step_no)
        end
      end
    else
      #redirect_to steps page
    end
    redirect_to steps_recipes_path(@recipe.slug)
  end

  def add_recipe_to_date
    @recipe=Recipe.find_by_slug(params[:recipe])    
    day=Date.parse(params[:date]).strftime("%A #{ Date.parse(params[:date]).day.ordinalize} %b %Y")
    food_type=FOOD_ROUTINES[params[:food_type].to_s].downcase
    unless @recipe.food_plans.where(:day=>Date.parse(params[:date]),:food_type=>params[:food_type],:family=>current_user.family).any?
      food_plan=@recipe.food_plans.create(:day=>params[:date],:food_type=>params[:food_type],:family=>current_user.family,:user=>current_user)      
      flash[:notice]="This recipe has been added to your calender for #{food_type} on #{day}"
    else
      flash[:error]="This recipe has already been added to your calender for #{food_type} on #{day}"
    end
    
    redirect_to @recipe
  end

  def edit
    unless @recipe.user==current_user
      flash[:error]="You dont have access to edit this recipe"
      redirect_to @recipe and return
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)    
    @recipe.user_id=current_user.id
    if @recipe.save
      redirect_to ingredients_recipes_path(@recipe.slug)
    else
      render :action=>'new'
    end
  end

  def update
    if @recipe.update(recipe_params)            
      redirect_to ingredients_recipes_path(@recipe.slug)
    else
      render :edit
    end
    
  end

  def destroy
    @recipe.destroy
    respond_with(@recipe)
  end

  private
    def set_recipe
      @recipe = Recipe.find_by_slug(params[:id])
    end

    def recipe_params
      params.require(:recipe).permit(:name,:description, :no_of_persons, :has_prerequisites, :recipe_type, :diet_type, :time_required, :user_id, :published,:category_slug,:picture,:hours,:minutes)
    end
    

    def prerequisities_params
      params.require(:step).permit(:desc=>[],:step_no=>[])
    end
    def steps_params
      params.require(:step).permit(:desc=>[],:step_no=>[])
    end
end
